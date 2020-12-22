class BadEquation

  def initialize(eq)
    @eq = eq.gsub(" ","")
    #puts "EQ: #{@eq}"
  end

  def eval(cursor = 0)
    loop do
      #puts "l cursor:#{cursor}"
      cursor, left = scan_number(cursor)
      #puts "o cursor:#{cursor}"
      cursor, operator = scan_operator(cursor)
      return left if operator == ')' || operator.nil?

      #puts "r cursor:#{cursor}"
      cursor, right = scan_number(cursor)
      #puts "e cursor:#{cursor}"

      res = left.send(operator.to_sym, right)

      @eq = "#{res}#{@eq[cursor..]}"
      cursor = 0

    end
  end

  def scan_number(cursor)
    #puts "scan: #{@eq[cursor..]}"
    if @eq[cursor] == '('
      end_cursor = end_paren(@eq[cursor..])
      #puts " scan paren: #{@eq[cursor+1..cursor+end_cursor-1]}"
      return cursor+end_cursor+1, BadEquation.new(@eq[cursor+1..end_cursor+cursor-1]).eval
    end

    number = @eq[cursor..].match(/(\d+)/)[1]
    return cursor+(number.length), number.to_i
  end

  def scan_operator(cursor)
    return cursor+1, @eq[cursor]
  end

  def end_paren(eq)
    paren_count = 0
    eq.chars.each_with_index do |c, i|
      paren_count += 1 if c == '('
      paren_count -= 1 if c == ')'
      #puts "#{i}--#{paren_count}"
      return i if paren_count == 0
    end
    raise "we should not get here"
  end

end
