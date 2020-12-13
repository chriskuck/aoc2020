require 'pry'
require './ship'

exit(1) unless !ARGV[0].nil? && File.exist?(ARGV[0])
instructions = File.read(ARGV[0]).split("\n")

decoded_instructions = instructions.map { |i| i.match(/([NESWLRF])(\d+)/)[1..2] }

ship = Ship.new
decoded_instructions.each { |i| ship.go(i) }
puts "Part 1: #{ship.manhatten_distance}"
