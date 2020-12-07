require './bag'
require 'pry'

exit(1) unless !ARGV[0].nil? && File.exist?(ARGV[0])
baggage_rules = File.read(ARGV[0]).split("\n")

bag_regex = /([a-z ]+) bags/

rules = baggage_rules
  .map { |rule| rule.match(/(.*) contain (.*)/).to_a[1..] }
  .each { |rule| rule[0] = rule[0].match(bag_regex).to_a[1..] }
  .each { |rule| rule[1] = rule[1].gsub('.','') }
  .each { |rule| rule[1] = rule[1].split(',') }
  .each { |rule| rule[1] = rule[1].map { |subrule| subrule.match(/(\d+) ([a-z ]+) bags?/).to_a[1..] } }


bags = []
rules.each do |bag_rule|
  bags << Bag.new(bag_rule[0][0]) unless bags.any? {|bag| bag.name == bag_rule[0] }
  bag_rule[1].each do |bag_content_rule|
    next if bag_content_rule.nil?
    bags << Bag.new(bag_content_rule[1]) unless bags.any? {|bag| bag.name == bag_content_rule[1] }
  end
end

rules.each do |bag_rule|
  bag_rule[0] = bags.find { |bag| bag.name == bag_rule[0][0] }
  bag_rule[1].each do |subrule|
    next if subrule.nil?
    subrule[1] = bags.find { |bag| bag.name == subrule[1] }
  end
end

rules.each do |bag_rule|
  bag_rule[0].add_points_to(bag_rule[1])
end

puts "part 1:"
puts (rules.find { |r| r[0].name == 'shiny gold' }[0].get_nodes_up.uniq - ["shiny gold"]).length


puts "part 2:"
puts rules.find { |r| r[0].name == 'shiny gold' }[0].get_bags_down - 1
