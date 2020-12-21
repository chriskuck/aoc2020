class CubeLifeAlt4D

  attr_accessor :world
  def initialize
    @world = []
  end

  def set_state(state)
    state.each_with_index do |line, y|
      line.chars.each_with_index do |cell, x|
        activate(x,y,0,0) if cell == "#"
      end
    end
  end

  def bounds
    min = [@world.map{|c|c[0]}.min,@world.map{|c|c[1]}.min,@world.map{|c|c[2]}.min, @world.map{|c|c[3]}.min]
    max = [@world.map{|c|c[0]}.max,@world.map{|c|c[1]}.max,@world.map{|c|c[2]}.max, @world.map{|c|c[3]}.max]
    [min,max]
  end

  def clone
    dup = CubeLifeAlt4D.new
    dup.world = self.world.dup
    dup
  end

  def step
    next_step = self.clone()

    min, max = bounds

    all_entries = (min[0]-1..max[0]+1).to_a.product((min[1]-1..max[1]+1).to_a, (min[2]-1..max[2]+1).to_a, (min[3]-1..max[3]+1).to_a)

    all_entries.each do |x,y,z,w|
      active_neighbors = neighbors(x,y,z,w).cout {|n| lookup(*n) == :active}
      #puts " #{[x,y,z]}:#{lookup(x,y,z)} -> #{active_neighbors}"
      if lookup(x,y,z,w) == :active
        next_step.deactivate(x,y,z,w) if active_neighbors != 2 && active_neighbors != 3
      else
        next_step.activate(x,y,z,w) if active_neighbors == 3
      end
    end

    next_step
  end

  def neighbors(x,y,z,w)
    ((x-1..x+1).to_a.product((y-1..y+1).to_a, (z-1..z+1).to_a, (w-1..w+1).to_a) - [[x,y,z,w]]).to_enum(:each)
  end

  def active
    @world
  end

  def to_s(l = 0)
    min, max = bounds
    (min[1]..max[1]).map{ |y|
      (min[0]..max[0]).map { |x|
        lookup(x,y,l) == :active ? "#":"."
      }.join
    }
  end

  def lookup(x,y,z,w)
    return :active if @world.include?([x,y,z,w])
    :inactive
  end

  def activate(x,y,z,w)
    @world << [x,y,z,w] if !@world.include?( [x,y,z,w] )
  end

  def deactivate(x,y,z,w)
    @world = @world - [[x,y,z,w]]
  end
end
