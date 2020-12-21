require 'pry'
require './cube_life'
require './cube_life_alt'
require './cube_life_alt_4d'

exit(1) unless !ARGV[0].nil? && File.exist?(ARGV[0])
life_cubes_state = File.read(ARGV[0]).split("\n")

cubes = [CubeLifeAlt.new]
cubes[0].set_state(life_cubes_state)

(0..5).each do |n|
  cubes << cubes[n].step
end

puts "Part 1: #{cubes[6].active.count}"


cubes = [CubeLifeAlt4D.new]
cubes[0].set_state(life_cubes_state)

(0..5).each do |n|
  cubes << cubes[n].step
end

puts "Part 2: #{cubes[6].active.count}"
