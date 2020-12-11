require './seats'
require './seat'

class SeatLife
  def initialize(world)
    @seats = Seats.new(world)
    @new_seats = nil
  end

  def step
    @new_seats = @seats.copy
    (0..@seats.height-1).each do |y|
      (0..@seats.length-1).each do |x|
        sim(x,y)
      end
    end
    @seats = @new_seats
    @new_seats = nil
  end

  def sim_part1(x,y)
    if @seats[[x,y]].empty?
      @new_seats[[x,y]].occupied if @seats.occupied_neighbors(x,y).length == 0
    elsif @seats[[x,y]].occupied?
      @new_seats[[x,y]].empty if @seats.occupied_neighbors(x,y).length >= 4
    end
  end

  def sim(x,y)
    if @seats[[x,y]].empty?
      @new_seats[[x,y]].occupied if @seats.see_occupied_neighbors(x,y).length == 0
    elsif @seats[[x,y]].occupied?
      @new_seats[[x,y]].empty if @seats.see_occupied_neighbors(x,y).length >= 5
    end
  end

  def find_stable_step
    (0..100000).each do |i|
      before = @seats.to_s
      step
      return @seats.all_occupied.count if @seats.to_s == before
    end
  end

  def to_s
    "World:\n#{@seats.to_s}\n------"
  end
end
