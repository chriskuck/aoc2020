class Memory
  attr_accessor :memory, :last

  def initialize
    self.memory = {}
    self.last = nil
  end

  def add(n,i)
    if !self.memory.include?(n)
      self.memory[n] = [i]
    else
      self.memory[n] = [memory[n].last,i]
    end
    self.last = n
  end

  def [](n)
    return memory[n] if memory.include?(n)
    nil
  end
end
