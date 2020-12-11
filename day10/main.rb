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

def add_one(arr)
  return if arr.length <= 1

  (0..arr.length-2).map do |i|
    new_arr = arr.clone()
    new_arr[i] += new_arr.delete_at(i+1)
    new_arr
  end
end

def compute_permutations(arr)
  solutions = []
  to_process = []
  to_process << arr

  while !to_process.empty?
    soln = to_process.pop
    solutions << soln
    new_solutions = add_one(soln)
    to_process.concat(new_solutions) if !new_solutions.nil?
  end

  solutions.uniq.select {|s| !s.any? {|is| is > 3 } }.count
end

distances = raw_adapters.clone().prepend(0).sort.each_cons(2).map {|p| p[1]-p[0]}
faux_trees = array_split(distances,3)
puts "Part 2: #{faux_trees.map {|ft| compute_permutations(ft) }.inject(:*)}"

