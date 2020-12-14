require './machine'

class AddressMachine < Machine

  private

  def apply_memset(memset)
    location = memset[1].to_i
    value = memset[2].to_i

    mask_permutations(apply_mask(location)).each do |mask_perm|
      self.memory[mask_perm.to_i(2)] = value
    end
  end

  def apply_mask(value)
    value.to_s(2).rjust(36,"0").chars.zip(mask.chars).map{|p| p[1]=="X"?"X":p[1]=="0"?p[0]:"1" }.join
  end

  def mask_permutations(val)
    masks = [val]
    perms = []
    while !masks.empty? do
      working_mask = masks.pop
      if !working_mask.include?("X")
        perms << working_mask
      else
        working_index = working_mask.index("X")
        working_mask_0 = working_mask.clone()
        working_mask_0[working_index] = "0"
        masks << working_mask_0
        working_mask_1 = working_mask.clone()
        working_mask_1[working_index] = "1"
        masks << working_mask_1
      end
    end
    perms
  end

end
