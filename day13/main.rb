require 'pry'

exit(1) unless !ARGV[0].nil? && File.exist?(ARGV[0])
schedule = File.read(ARGV[0]).split("\n")

t0 = schedule[0].to_i
buses = schedule[1].split(",").select{|b| b != "x" }.map(&:to_i).sort

dist_id = buses.map do |b|
  ((t0/b)+1)*b - t0
end.zip(buses).min_by { |p| p[0] }

puts "Part 1: #{dist_id.inject(:*)}"

id_rem = schedule[1]
  .split(",")
  .zip((0..schedule[1].length-1))
  .select{ |p| p[0] != "x" }
  .each{ |p| p[0] = p[0].to_i }

def find_offset(x,y)
  c = y[1]
  loop do
    return c if (c+x[1]) % x[0] == 0
    c += y[0]
  end
end

ans = (id_rem - [id_rem[0]]).reduce(id_rem[0]) do |memo, val|
  offset = find_offset(val, memo)
  [val[0]*memo[0], offset]
end

puts "Part 2: #{ans[1]}"
