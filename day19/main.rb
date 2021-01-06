require 'pry'
require './rules'
require './infinite_rules_4231'

exit(1) unless !ARGV[0].nil? && File.exist?(ARGV[0])
rules_and_examples = File.read(ARGV[0]).split("\n")

rule_break = rules_and_examples.index do |line| line == "" end
rules_text = rules_and_examples[..rule_break-1]
examples = rules_and_examples[rule_break+1..]

rules = Rules.new(rules_text)

valid = examples.select do |example|
  rules.apply(0, example)
end

puts "Part 1: #{valid.count}"

rules = InfiniteRules4231.new(rules_text)

puts "Rules are invalid for part 2" if !rules.valid?
exit(1) if !rules.valid?

valid = examples.select do |example|
  rules.apply(0, example)
end

puts "Part 2: #{valid.count}"
