require 'pry'
require './interpreter'

exit(1) unless !ARGV[0].nil? && File.exist?(ARGV[0])
program = File.read(ARGV[0]).split("\n")

interpreter = Interpreter.new
interpreter.load(program)
binding.pry
interpreter.run_no_dups
puts "Part 1: #{interpreter.state}"
