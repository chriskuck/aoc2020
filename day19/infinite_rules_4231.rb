require './rules'

class InfiniteRules4231 < Rules

  def valid?
    @rules[0] == [8,11] && @rules[8] == [42] && @rules[11] == [42, 31]
  end


  # must have 42 42 31
  def apply(index, example)

    # only run this if we're doing rule 0 (this is hardcoded)
    return false if index != 0

    m42 = match_as_many(42, example)

    return false if m42.length < 2

    m42.each do |n_42s, state|
      m31 = match_as_many(31,state)
      n_31s, final = m31.last
      return true if final == "" && n_31s >= 1 && n_42s >= 2 && n_31s < n_42s
    end

    # just return false here because we couldn't find a configuration of 42s and 31s.
    false
  end

  def match_as_many(rule, example)

    # states for later
    states = []
    count = 0

    sub_example = example.dup
    loop do
      success, match_length = apply_rule(rule, sub_example)
      break if !success
      count += 1
      sub_example = sub_example[match_length..]
      states << [count, sub_example]
    end
    states
  end

end
