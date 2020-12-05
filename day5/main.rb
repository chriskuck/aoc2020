require 'pry'

exit(1) unless !ARGV[0].nil? && File.exist?(ARGV[0])
boarding_passes = File.read(ARGV[0]).split

(0..901).each { |i| puts i }
boarding_passes.each do |pass|
  match = pass.match(/([FB]{7})([LR]{3})/)
  row = match[1].chars.map{ |c| c == "B" ? 1 : 0 }.join.to_i(2)
  col = match[2].chars.map{ |c| c == "R" ? 1 : 0 }.join.to_i(2)
  puts "#{row*8+col}"
end
