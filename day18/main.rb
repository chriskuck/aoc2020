require 'pry'
require './bad_equation.rb'

exit(1) unless !ARGV[0].nil? && File.exist?(ARGV[0])
eqs = File.read(ARGV[0]).split("\n")

ans = eqs.map do |eq|
  puts "#{eq} = #{BadEquation.new(eq).eval}"
  BadEquation.new(eq).eval
end

puts "Part 1: #{ans.inject(:+)}"
