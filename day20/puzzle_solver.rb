require './tile'

class PuzzleSolver

  def self.parse_input(input)
    tiles = []
    tile_strings = array_split(input, "")
    tile_strings.each do |t|
      id = t[0].match(/Tile (\d+):/)[1]

      tiles << Tile.new(id, t[1..])
    end
    tiles
  end

  def self.array_split(array, value = nil)
    arr = array.dup
    result = []
    while (idx = arr.index(value))
      result << arr.shift(idx)
      arr.shift
    end
    result << arr
  end

  attr_accessor :tiles, :answer

  def initialize(tiles)
    self.tiles = tiles
    self.answer = nil
  end

  def solve_edges
    # make a hash of all edges + hash
    all_edges = {}
    self.tiles.each do |tile|
      tile.edge_hashes
        .each { |eh| all_edges[eh] ||= [] }
        .each { |eh| all_edges[eh.reverse] ||= [] }
        .each { |eh| all_edges[eh] << tile.id }
        .each { |eh| all_edges[eh.reverse] << tile.id }
    end
    puzzle_edges = all_edges.select { |k,v| v.length == 1 }.values.map { |edge| edge[0] }.uniq

    puzzle_edges.each do |edge_id|
      edge_tile = self.tiles.select { |t| t.id == edge_id }
      touched_edges = edge_tile.first.edge_hashes.map { |eh| all_edges[eh] }.flatten
        .select { |edge| edge != edge_id && puzzle_edges.include?(edge) }.uniq
    end

    # welp, thats not how i wanted to solve that.
    @corners = tiles
      .map{|t| t.id}
      .map {|id| all_edges.select { |k,v| v.include? id } }
      .map {|edges| edges.select { |k,v| v.length > 1 }
      .map { |k,v| v }.uniq }
      .select{|em| em.count == 2 }
      .map { |em| em.flatten}
      .map{ |em| em.group_by { |v| v }.select { |k,v| v.count == 2 } }
      .map {|e| e.keys[0]}
      .map {|e| e.to_i }


  end

  def corners
    # temporary, will fix later
    @corners
  end

end
