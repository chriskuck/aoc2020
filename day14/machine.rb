
class Machine

  attr_accessor :memory, :mask

  def initialize
    self.memory = Hash.new
    self.mask = 36.times.map{"X"}.join
  end

  def apply(line)
    mask_match = line.match(/mask = ([X01]{36})/)
    memset_match = line.match(/mem\[(\d+)\] = (\d+)/)

    raise "bad line" if mask_match.nil? && memset_match.nil?

    apply_memset(memset_match) if memset_match
    set_mask(mask_match) if mask_match

  end

  def all
    memory.values
  end

  private

  def apply_memset(memset)
    location = memset[1].to_i
    value = memset[2].to_i
    self.memory[location] = apply_mask(value)
    self.memory.remove(location) if self.memory[location] == 0
  end

  def set_mask(mask)
    self.mask = mask[1]
  end

  def apply_mask(value)
    value.to_s(2).rjust(36,"0").chars.zip(mask.chars).map{|p| p[1]=="X"?p[0]:p[1] }.join.to_i(2)
  end

end
