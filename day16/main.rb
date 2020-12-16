require 'pry'

exit(1) unless !ARGV[0].nil? && File.exist?(ARGV[0])
input = File.read(ARGV[0])

def parse_rules(rules)
  rules.map do |rule|
    name, rule = rule.split(":")
    ranges = rule.split(" or ")
      .map(&:strip)
      .map {|r| r.match(/(\d+)-(\d+)/)[1..2].map(&:to_i) }
      .map{ |s,e| (s..e) }
    [name, ranges]
  end
end

rules, tickets = input.split("your ticket:\n")
$rules = parse_rules(rules.split("\n"))
$tickets = tickets.split("nearby tickets:\n")
  .map{|t| t.split("\n")}
  .flatten
  .map do |t|
    t.split(",")
     .map{|e| e.to_i }
   end


def valid_field(field, rules)
  rules.any? do |name, ranges|
    ranges.any? do |range|
      range.include?(field)
    end
  end

end

def invalid_fields(ticket, rules)
  ticket.select do |field|
    !valid_field(field, rules)
  end
end

answer = $tickets.select{|t| invalid_fields(t, $rules) }
puts "Part 1: #{answer.flatten.inject(:+)}"

valid_tickets = $tickets.select{|t| invalid_fields(t, $rules).empty? }

fields = (0..$tickets[0].length-1).map{|i| valid_tickets.map{|t| t[i]}}
initial_rules_soln = fields.map.with_index do |f_arr, i|
  valid_rules = $rules.select do |name, ranges|
    f_arr.all? do |field_val| 
      ranges.any? {|range| range.include?(field_val)}
    end
  end
  [i, *valid_rules]
end

solution = []
while !initial_rules_soln.empty?
  finished_rule =initial_rules_soln.find { |rule_set_and_index| rule_set_and_index.count == 2 }
  solution << [finished_rule[0], finished_rule[1][0]]
  initial_rules_soln = initial_rules_soln - [finished_rule]
  initial_rules_soln = initial_rules_soln.map {|rule_set_and_index| rule_set_and_index - [finished_rule[1]] }
end

depature_fields = solution.select { |s| s[1].include?("departure") }
puts "Part 2: #{depature_fields.map{|f|f[0]}.map{|index| $tickets[0][index]}.inject(:*)}"



