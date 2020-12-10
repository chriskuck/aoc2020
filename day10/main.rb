require 'pry'

exit(1) unless !ARGV[0].nil? && File.exist?(ARGV[0])
raw_adapters = File.read(ARGV[0]).split("\n").map(&:to_i)

adapters = raw_adapters.clone().prepend(0).sort
adapters << adapters.max + 3

distances = adapters.each_cons(2).map {|p| p[1]-p[0]}
counts = distances.inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }
puts "Part 1: #{counts[1]*counts[3]}"

def array_split(array, delim)
  new_array =  []
  new_inner_array = []
  array.each do |e|
    if e != delim
      new_inner_array << e
    else
      new_array << new_inner_array
      new_inner_array = []
    end
  end
  new_array << new_inner_array
  new_array
end

def compute_permutations(arr)
  return 7 if arr.length == 4
  return 4 if arr.length == 3
  return 2 if arr.length == 2
  return 1 if arr.length <= 1
end

distances = raw_adapters.clone().prepend(0).sort.each_cons(2).map {|p| p[1]-p[0]}
faux_trees = array_split(distances,3)
binding.pry
puts "Part 2: #{faux_trees.map {|ft| compute_permutations(ft) }.inject(:*)}"

