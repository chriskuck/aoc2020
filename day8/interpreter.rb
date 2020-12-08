class Interpreter

  def initialize
    @program = nil
    @pc = 0
    @state = { acc: 0}
  end

  # takes in string programs
  # OP ARG
  def load(program)
    @program = program
    validate_program
  end

  def step
    @pc = exec(@program,@pc,@state)
  end

  def run
    while @pc != -1
      @pc = exec(@program,@pc,@state)
    end
  end

  def run_no_dups
    instructions_run = []
    while !instructions_run.include?(@pc)
      instructions_run << @pc
      @pc = exec(@program, @pc, @state)
    end
  end

  def state
    @state
  end

  private

  def validate_program
    return false if @program.nil?
    # do a regex scan here to make sure program is right
    return true
  end

  def exec(instructions, pc, state)
    decode = parse_instruction(instructions[pc])

    case decode[0]
    when 'nop'
      return pc + 1
    when 'jmp'
      return pc + decode[1]
    when 'acc'
      state[:acc] += decode[1]
      return pc + 1
    else
      raise "Not Implemented"
    end
  end

  def parse_instruction(instruction)
    match = instruction.match(/(nop|acc|jmp) ([+-]\d+)/)
    raise "Bad Instruction" if match.nil?
    [match[1],match[2].to_i]
  end
end
