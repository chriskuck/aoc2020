class Tile

  attr_accessor :id, :rows
  def initialize(id, tile_rows)
    self.id = id
    self.rows = tile_rows
  end
  
  def edge_hashes
    [rows.first, rows.map {|r| r.chars.last }.join, rows.last, rows.reverse.map {|r| r.chars.first }.join]
  end
end
