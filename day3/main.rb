require './tree_world'
require 'pry'

exit(1) unless !ARGV[0].nil? && File.exist?(ARGV[0])
map = File.read(ARGV[0])

world = TreeWorld.new(map.split)

puts world.intersect([0,0],[3,1])
