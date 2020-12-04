require './tree_world'
require 'pry'

exit(1) unless !ARGV[0].nil? && File.exist?(ARGV[0])
map = File.read(ARGV[0])

world = TreeWorld.new(map.split)

[[1,1],[3,1], [5,1], [7,1], [1,2]].each do |slope|
  puts "#{slope.to_s} - #{world.intersect([0,0],slope)}"
end
