require 'pry'

exit(1) unless !ARGV[0].nil? && File.exist?(ARGV[0])
numbers = File.read(ARGV[0]).split(",").map(&:to_i)


(numbers.length..2020-1).each do |i|
  next_to_last_index = numbers[0..numbers.length-2].rindex(numbers[i-1])
  numbers << (next_to_last_index.nil?()? 0 : numbers.length-1 - next_to_last_index)
end

puts "Part 1: #{numbers.last}"

