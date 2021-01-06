class Rules

  def initialize(text)
    @rules = parse_rules(text)
    @mah_42s = 0
  end

  def [](index)
    @rules[index]
  end

  def apply(index, example)
    success, match_length = apply_rule(0, example)
    return success && match_length == example.length
  end

  private

  def parse_rules(lines)

    rules = {}
    lines.each_with_index do |line, index|
      index_rule = line.split(":")
      rule = index_rule[1].strip!.split(" ")
      if rule.length == 1 && rule[0].match(/\A[0-9]*\Z/).nil?
        rules[index_rule[0].to_i] = rule[0].gsub!("\"","")
      else
        rules[index_rule[0].to_i] = rule.map { |i| i != "|" ? i.to_i : :OR }
      end
      #puts "#{index_rule[0].to_i}: #{rules[index_rule[0].to_i]}"
    end
    rules

  end

  def apply_rule(index, example)
    #puts "APPLY: #{index} #{example}"
    if @rules[index].is_a? String
      return apply_STR_rule(index, example)
    elsif @rules[index].include? :OR
      return apply_OR_rule(index, example)
    else
      return apply_MULTI_rule(@rules[index], example)
    end
  end

  def apply_MULTI_rule(rule_array, example)
    #puts "MULTI: #{rule_array} #{example}"
    # e.g. 4 1 5
    sub_example = example.dup
    total_length = 0

    rule_array.each do |sub_rule_index|
      success, match_length = apply_rule(sub_rule_index, sub_example)
      return [false, 0] if !success
      sub_example = sub_example[match_length..]
      total_length += match_length
    end
    [true, total_length]
  end

  def apply_STR_rule(index, example)
    #puts "STR: #{index} #{example}"

    rule_length = @rules[index].length
    if rule_length <= example.length && example[0..rule_length-1] == @rules[index]
      #puts "true"
      return [true, rule_length]
    end
    #puts "false"
    [false,0]
  end

  def apply_OR_rule(index, example)
    #puts "OR: #{index} #{example}"
    rules = array_split(@rules[index], :OR)
    #puts "apply OR1"
    success, match_length = apply_MULTI_rule(rules[0], example)
    return [success, match_length] if success
    #puts "apply OR2"
    success, match_length = apply_MULTI_rule(rules[1], example)
    return [success, match_length] if success
    [false, 0]
  end

  def array_split(array, value = nil)
    arr = array.dup
    result = []
    while (idx = arr.index(value))
      result << arr.shift(idx)
      arr.shift
    end
    result << arr
  end
end
