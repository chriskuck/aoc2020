require 'pry'
require './puzzle_solver'

exit(1) unless !ARGV[0].nil? && File.exist?(ARGV[0])
puzzle_input = File.read(ARGV[0]).split("\n")

tiles = PuzzleSolver.parse_input(puzzle_input)

solver = PuzzleSolver.new(tiles)
solver.solve_edges

puts "Part 1: #{solver.corners.inject(:*)}"

puts "Part 2: (shrug)"
