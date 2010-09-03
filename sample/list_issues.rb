$:<<File.expand_path("#{__FILE__}/../../lib")
require 'redmined'
session = Redmined::Session.new("https://wiki.borderstylo.com/","LOGIN","PASSWORD")
session.issues("products").sort_by(&:priority).each do |issue|
	puts "#{issue.number}: #{issue.title}"
	puts "PRIORITY: #{issue.priority} / CATEGORY: #{issue.category}"
	puts "-"*80
end

