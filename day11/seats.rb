require './seat'

class Seats

  def initialize(world)
    @world = []
    world.each do |line|
      row = []
      line.chars.each do |seat_status|
        row << Seat.new(seat_status)
      end
      @world << row
    end
  end

  def copy
    Seats.new(self.to_s.split("\n"))
  end

  def height
    @world.length
  end
  def length
    @world[0].length
  end

  def [](coords)
    @world[coords[1]][coords[0]]
  end

  def occupied_neighbors(x,y)
    neighbors = []
    (x-1..x+1).each do |nx|
      (y-1..y+1).each do |ny|
        neighbors << self[[nx,ny]] if valid_coord(nx, ny) && self[[nx,ny]].occupied? && [nx,ny] != [x,y]
      end
    end
    neighbors
  end

  def to_s
    @world.map do |row|
      row.map do |cell|
        cell.to_s
      end.join
    end.join("\n")
  end

  def all_occupied
    occupied = []
    (0..length-1).each do |x|
      (0..height-1).each do |y|
        occupied << self[[x,y]] if self[[x,y]].occupied?
      end
    end
    occupied
  end

  private

  def valid_coord(x,y)
    return false if x < 0 || x >= length
    return false if y < 0 || y >= height
    true
  end
end
