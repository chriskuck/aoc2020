require './ship'

class WaypointShip < Ship
  attr_accessor :waypoint

  def initialize
    super()
    @waypoint = [10,1]
  end

  def R(units)
    (0..(units/90)-1).each do
      t = waypoint[0]
      waypoint[0] = waypoint[1]
      waypoint[1] = -t
    end
  end

  def L(units)
    (0..(units/90)-1).each do
      t = waypoint[0]
      waypoint[0] = -waypoint[1]
      waypoint[1] = t
    end
  end

  def N(units) waypoint[1] += units end
  def S(units) waypoint[1] -= units end
  def E(units) waypoint[0] += units end
  def W(units) waypoint[0] -= units end

  def F(units)
    self.location = waypoint.map{ |c| c*units }.zip(location).map{ |c| c[0]+c[1] }
  end
end
