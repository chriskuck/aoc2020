require 'pry'

exit(1) unless !ARGV[0].nil? && File.exist?(ARGV[0])
encoded = File.read(ARGV[0]).split("\n").map(&:to_i)

exit(1) unless !ARGV[1].nil?
window_size = ARGV[1].to_i

first_bad_index = (window_size..encoded.length-1).find do |i|
  window = encoded[i-window_size..i-1]
  window.find do |l|
    (window.clone() -[l]).find do |r|
      l+r == encoded[i]
    end
  end == nil
end

puts "Part 1: #{encoded[first_bad_index]}"

target = encoded[first_bad_index]

store_j = nil
store_i = (0..encoded.length-2).find do |i|
  (i+1..encoded.length-1).find do |j|
    store_j = j if encoded[i..j].inject(:+) == target
    encoded[i..j].inject(:+) == target
  end
end

puts "Part 2: #{encoded[store_i..store_j].min+encoded[store_i..store_j].max}"
