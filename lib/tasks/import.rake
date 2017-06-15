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
        Law.create(title: law)
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
        Organization.create(name: org)
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

        l.drafts.create(published_at: dd, document: doc)
        unknown += 1
      end
    end

    puts "Import finished. already known: #{known}, new: #{unknown}"
  end
end