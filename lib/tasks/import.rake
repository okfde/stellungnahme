require 'smarter_csv'

namespace :import do
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
end