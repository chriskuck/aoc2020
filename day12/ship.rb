class Ship
  attr_accessor :location, :heading

  def initialize
    @location = [0,0]
    @heading = 0
  end

  def go(command)
    self.send(command[0], command[1].to_i)
  end

  def manhatten_distance
    location[0].abs + location[1].abs
  end

  def R(units) self.heading = (heading + (units/90)) % 4 end
  def L(units)  self.heading = (heading - (units/90)) % 4 end

  def N(units) location[1] += units end
  def S(units) location[1] -= units end
  def E(units)  location[0] += units end
  def W(units)  location[0] -= units end

  def F(units)
    case heading
    when 0 then E(units)
    when 1 then S(units)
    when 2 then W(units)
    when 3 then N(units)
    end
  end
end
