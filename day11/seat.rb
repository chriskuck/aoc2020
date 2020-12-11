class Seat

  def initialize(status)
    @status = status
  end

  def empty?
    @status == 'L'
  end

  def empty
    @status = 'L'
  end

  def occupied?
    @status == '#'
  end

  def occupied
    @status = '#'
  end

  def to_s
    @status
  end

end
