class MultDomEquation

  def initialize(equation)
    @tokens = tokenize(equation)
  end

  def tokenize(equation)
    equation.chars.map do |c|
      case c
      when '(' then :L
      when ')' then :R
      when '*' then :MULT
      when '+' then :ADD
      when ' ' then nil
      else c.to_i
      end
    end.compact
  end


  def eval
    ieval(0, @tokens.length-1)
  end

  def ieval(eq_start, eq_end)

    #puts "ieval: (#{eq_start},#{eq_end}) #{to_s(eq_start,eq_end)}"

    eq_start, eq_end = process_parens(eq_start, eq_end)
    eq_start, eq_end = process_adds(eq_start, eq_end)
    eq_start, eq_end = process_mults(eq_start, eq_end)

    @tokens[eq_start]
  end

  def process_parens(s,e)
    #puts "parens: (#{s},#{e}) #{to_s(s,e)}"

    cursor = s
    loop do
      if @tokens[cursor] == :L
        rval = find_r(cursor)
        e -= (rval - cursor)
        replace(cursor, cursor+2, ieval(cursor+1, rval-1) )
      else
        cursor += 2
        break if cursor >= e
      end
    end
    [s,e]
  end


  def process_adds(s,e)
    #puts "adds: (#{s},#{e}) #{to_s(s,e)}"

    cursor = s
    loop do
      if @tokens[cursor+1] == :ADD
        e -= 2
        replace(cursor, cursor+2, @tokens[cursor] + @tokens[cursor+2])
      else
        cursor += 2
        break if cursor >= e
      end
    end
    [s,e]
  end


  def process_mults(s,e)
    #puts "mults: (#{s},#{e}) #{to_s(s,e)}"

    cursor = s
    loop do
      if @tokens[cursor+1] == :MULT
        e -= 2
        replace(cursor, cursor+2, @tokens[cursor] * @tokens[cursor+2])
      else
        cursor += 2
        break if cursor >= e
      end
    end
    [s,e]
  end

  def to_s(s,e)
    str = ""
    (s..e).each do |cursor|
      case @tokens[cursor]
      when :L then str += "("
      when :R then str += ")"
      when :MULT then str += "*"
      when :ADD then str += "+"
      else str += @tokens[cursor].to_s
      end
    end
    str
  end


  def replace(s, e, val)
    #puts "replace: #{to_s(s,e)} -> #{val}"
    (s..e-1).each do |c|
      @tokens.delete_at(s)
    end
    @tokens[s] = val
  end

  def find_r(cursor)
    #puts "find_r: #{@tokens[cursor..]}"
    paren_count = 0
    @tokens[cursor..].each_with_index do |t, i|
      #puts "#{paren_count} #{t} #{i}"
      paren_count += 1 if t == :L
      paren_count -= 1 if t == :R
      #puts "return -> #{cursor+i}" if paren_count == 0
      return cursor+i if paren_count == 0
    end
    raise "we should not get here"
  end

end
