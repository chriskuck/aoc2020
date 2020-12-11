require 'pry'
require './seat_life'

exit(1) unless !ARGV[0].nil? && File.exist?(ARGV[0])
world = File.read(ARGV[0]).split("\n")

seat_life = SeatLife.new(world)
# note, part1 is in git history, didn't feel like maintaining two
puts "Part 2: #{seat_life.find_stable_step}"
