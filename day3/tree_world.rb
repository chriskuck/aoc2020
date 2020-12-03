class TreeWorld

  attr_accessor :map

  def initialize(map)
    parse_map(map)
  end

  def sample(coord)
    norm_coord = [nx(coord[0]), coord[1]]
    @map[norm_coord[1]][norm_coord[0]]
  end

  def intersect(start, slope)
    done = false
    cursor = [start[0], start[1]]
    results = {empty:0, tree:0}


    while !done do
      results[sample(cursor)] += 1

      cursor[0] = cursor[0]+slope[0]
      cursor[1] = cursor[1]+slope[1]

      done = true if cursor[1] >= @real_height
    end

    results
  end

  private

  def parse_map(map)
    @real_width = map[0].length
    @real_height = map.length
    @map = []
    map.each_with_index do |map_line, y|
      @map[y] = []
      map_line.each_char.with_index do |c, x|
        @map[y][x] = c == '.' ? :empty : :tree
      end
    end
  end

  def nx(coord_x)
    return coord_x % @real_width
  end
end
