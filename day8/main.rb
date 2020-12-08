require 'pry'
require './interpreter'
require './analyzer'

exit(1) unless !ARGV[0].nil? && File.exist?(ARGV[0])
program = File.read(ARGV[0]).split("\n")

i = Interpreter.new
i.load(program)
i.run_no_dups
puts "Part 1: #{i.state[:acc]}"

analyzer = Analyzer.new(program, i.state[:instructions_run])
program = analyzer.modify

i = Interpreter.new
i.load(program)
raise "uhh, this didn't work" if !i.run_no_dups

puts "Part 2: #{i.state[:acc]}"

