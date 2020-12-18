class CubeLife

  attr_accessor :world

  def initialize(state)
    self.world = []

    state.each_with_index do |line, y|
      line.chars.each_with_index do |cell, x|
        activate(x,y,0) if cell == "#"
      end
    end
  end

  def step
    next_step = self.clone()

    puts "start step"
    processed = []
    active.each do |x,y,z|

      active_count = neighbors(x,y,z).count do |nx,ny,nz| lookup(nx,ny,nz) == :active end
      next_step.deactivate(x,y,z) if active_count < 2 || active_count > 3

      processed << [x,y,z]

      inactive_neighbors = neighbors(x,y,z).select { |nx, ny, nz| lookup(nx,ny,nz) == :inactive } 
      unprocessed_inactive = inactive_neighbors.select{|nx,ny,nz| !processed.include?([nx,ny,nz]) }
      unprocessed_inactive.each {|nx, ny, nz| processed << [nx,ny,nz] }
      a3_un_in = unprocessed_inactive.select {|nx,ny,nz| 
        inner_active_neighbors=neighbors(nx,ny,nz).select {|onx, ony, onz| lookup(onx,ony,onz) == :active }
        inner_active_neighbors.count == 3
      }
      a3_un_in.each{|nx,ny,nz| next_step.activate(nx,ny,nz) }

    end
    puts "end step"
    next_step
  end

  def neighbors(x,y,z)
    n = []
    (x-1..x+1).each do |ix|
      (y-1..y+1).each do |iy|
        (z-1..z+1).each do |iz|
          n << [ix, iy, iz] if ix != x || iy != y || iz != z
        end
      end
    end
    n.to_enum(:each)
  end

  def active
    world.each
  end

  def to_s(l = 0)
    (0..7).map{ |y|
      (0..7).map { |x|
        lookup(x,y,l) == :active ? "#":"."
      }.join
    }
  end

  def lookup(x,y,z)
    return :active if world.include?([x,y,z])
    :inactive
  end

  def activate(x,y,z)
    world << [x,y,z] if !world.include?( [x,y,z] )
  end

  def deactivate(x,y,z)
    self.world = world - [[x,y,z]]
  end
end
