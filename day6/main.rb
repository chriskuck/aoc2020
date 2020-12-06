require 'pry'

exit(1) unless !ARGV[0].nil? && File.exist?(ARGV[0])
customs_forms = File.read(ARGV[0])

sum_of_counts = customs_forms
  .split("\n")
  .join(",")
  .split(",,")
  .map { |s| s.gsub(",","").chars.uniq.join("") }
  .map { |s| s.length }.inject(:+)


puts "Part 1: #{sum_of_counts}"
