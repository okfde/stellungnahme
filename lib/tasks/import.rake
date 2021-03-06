require 'csv'
require 'smarter_csv'

namespace :import do
  desc 'import csv with laws'
  task :laws, [:path] => :environment do |_t, args|
    path = args[:path]
    raise 'Not found' unless File.exist? path

    data = SmarterCSV.process(path)
    laws = data.map { |m| m[:title] }.map(&:strip)
    laws = laws.sort.uniq

    known = 0
    unknown = 0
    laws.each do |law|
      o = Law.where('LOWER(title) LIKE ?', law.downcase)
      if o.count >= 1
        known += 1
      elsif o.count.zero?
        unknown += 1
        Law.create!(title: law)
      end
    end

    puts "Import finished. already known: #{known}, new: #{unknown}"
  end

  desc 'import csv with orgs'
  task :organizations, [:path] => :environment do |_t, args|
    path = args[:path]
    raise 'Not found' unless File.exist? path

    data = SmarterCSV.process(path)
    orgs = data.map { |m| m[:name] }.map(&:strip)
    orgs = orgs.sort.uniq

    known = 0
    unknown = 0
    orgs.each do |org|
      o = Organization.where('LOWER(name) LIKE ?', org.downcase)
      if o.count >= 1
        known += 1
      elsif o.count.zero?
        unknown += 1
        Organization.create!(name: org)
      end
    end

    puts "Import finished. already known: #{known}, new: #{unknown}"
  end

  desc 'import link between ministry and laws'
  task :ministry_laws, [:path] => :environment do |_t, args|
    path = args[:path]
    raise 'Not found' unless File.exist? path

    known = 0
    unknown = 0

    data = SmarterCSV.process(path)
    data.each do |row|
      m = Ministry.find_by_short_name(row[:ministry].strip)
      if m.nil?
        puts "Unknown Ministry: #{row[:ministry]}"
        next
      end

      l = Law.find_by_title(row[:law].strip)
      if l.nil?
        puts "Unknown Law: #{row[:law]}"
        next
      end

      puts "Found Pair: #{m.inspect} #{l.inspect}"
      if m.laws.exists?(l.id)
        puts "  old"
        known += 1
      else
        puts "! NEW"
        m.laws << l
        unknown += 1
      end
    end

    puts "Import finished. already known: #{known}, new: #{unknown}"
  end

  desc 'import drafts of laws'
  task :drafts, [:path] => :environment do |_t, args|
    path = args[:path]
    raise 'Not found' unless File.exist? path

    known = 0
    unknown = 0

    data = SmarterCSV.process(path)
    data.each do |row|
      l = Law.find_by_title(row[:law].strip)
      if l.nil?
        puts "Unknown Law: #{row[:law]}"
        next
      end

      doc = Document.find_by_source_url(row[:url].strip)
      draft = Draft.where(law: l, document: doc)
      if draft.count > 0
        puts "  old"
        known += 1
      else
        puts "! NEW"
        dd = nil
        dd = Date.parse(row[:date].strip) unless row[:date].blank?

        doc = Document.create(source_url: row[:url].strip) if doc.nil?

        l.drafts.create!(published_at: dd, document: doc)
        unknown += 1
      end
    end

    puts "Import finished. already known: #{known}, new: #{unknown}"
  end

  desc 'import comments'
  task :comments, [:path] => :environment do |_t, args|
    path = args[:path]
    raise 'Not found' unless File.exist? path

    known = 0
    unknown = 0

    data = SmarterCSV.process(path, convert_values_to_numeric: false)
    data.each do |row|
      law_name = row[:law].try(:strip)
      if law_name.blank?
        next
      end

      l = Law.find_by_title(law_name)
      if l.nil?
        puts "Unknown Law: #{law_name}"
        next
      end

      draft = l.drafts.first
      if draft.nil?
        puts "Law has no draft: #{l.title}"
        next
      end

      org_name = row[:org]
      if org_name.blank? || org_name.try(:strip) == 'x'
        puts "No Organization for Law: #{l.title}"
        next
      end

      clean_org_name = Organization.normalize(org_name)
      if clean_org_name.nil?
        puts "Nomenklatura says invalid: #{org_name}"
        next
      end

      o = Organization.where('LOWER(name) LIKE ?', clean_org_name.downcase).first
      if o.nil?
        puts "Unknown Organization: #{clean_org_name}"
        next
      end

      url = row[:url].try(:strip)
      doc = nil
      doc = Document.find_by_source_url(url) unless url.blank?
      comment = l.comments.where(document: doc).includes(:organizations).where(organizations: {id: o.id})
      if comment.count > 0
        puts "  old"
        known += 1
      else
        puts "! NEW"
        dd = nil
        begin
          dd = Date.parse(row[:date].strip) unless row[:date].blank?
        rescue
          puts "! date: unknown format: #{row[:date]}"
          dd = nil
        end

        doc = Document.create(source_url: url) if doc.nil? && !url.blank?
        if !doc.nil? && !doc.valid?
          puts "! doc: #{doc.inspect}, #{doc.errors.inspect}"
          doc = nil
        end

        l.comments.create!(organizations: [o], draft: draft, document: doc, answered_at: dd)
        unknown += 1
      end
    end

    puts "Import finished. already known: #{known}, new: #{unknown}"
  end

 desc 'unknown'
  task :unknown, [:path] => :environment do |_t, args|
    path = args[:path]
    raise "file,#{path}" unless File.exist? path

    out = CSV.new(STDOUT)

    data = SmarterCSV.process(path, convert_values_to_numeric: false)
    data.each do |row|
      law_name = row[:law].try(:strip)
      next if law_name.blank?

      l = Law.find_by_title(law_name)
      if l.nil?
        out << ['law', law_name]
        next
      end

      draft = l.drafts.first
      if draft.nil?
        out << ['draft', l.title]
        next
      end

      org_name = row[:org]
      next if org_name.blank? || org_name.try(:strip) == 'x'

      clean_org_name = Organization.normalize(org_name)
      if clean_org_name.nil?
        out << ['organization', org_name]
        next
      end

      o = Organization.where('LOWER(name) LIKE ?', clean_org_name.downcase).first
      out << ['organization', clean_org_name] if o.nil?
    end
  end
end