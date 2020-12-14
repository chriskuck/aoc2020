require 'pry'
require './machine'
require './address_machine'

exit(1) unless !ARGV[0].nil? && File.exist?(ARGV[0])
mask = File.read(ARGV[0]).split("\n")

machine = Machine.new
mask.each do |ml|
  machine.apply(ml)
end

binding.pry
puts "Part 1: #{machine.all.inject(:+)}"

machine = AddressMachine.new
mask.each do |ml|
  machine.apply(ml)
end

binding.pry
puts "Part 2: #{machine.all.inject(:+)}"
