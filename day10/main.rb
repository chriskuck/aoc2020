require 'pry'

exit(1) unless !ARGV[0].nil? && File.exist?(ARGV[0])
adapters = File.read(ARGV[0]).split("\n").map(&:to_i)

adapters = adapters.prepend(0).sort
adapters << adapters.max + 3

counts = adapters.each_cons(2).map {|p| p[1]-p[0]}.inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }
puts "Part 1: #{counts[1]*counts[3]}"
