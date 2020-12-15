require 'pry'
require './memory'

exit(1) unless !ARGV[0].nil? && File.exist?(ARGV[0])
raw_numbers = File.read(ARGV[0]).split(",").map(&:to_i)

numbers = raw_numbers.clone()
(numbers.length..2020-1).each do |i|
  next_to_last_index = numbers[0..numbers.length-2].rindex(numbers[i-1])
  numbers << (next_to_last_index.nil?()? 0 : numbers.length-1 - next_to_last_index)
end

puts "Part 1: #{numbers.last}"

memory = Memory.new
raw_numbers.each_with_index {|n,i| memory.add(n,i) }

(raw_numbers.length..30000000-1).each do |i|
  indices = memory[memory.last]
  memory.add( (indices[1] || indices[0]) - indices[0], i)
end

puts "Part 2: #{memory.last}"
