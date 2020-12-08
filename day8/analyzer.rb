
class Analyzer
  def initialize(program, run_order)
    @program = program
    @run_order = analyze_allowable_changes(program, run_order)
  end

  def modify
    real_program = nil
    ins = @run_order.reverse.detect do |ins_to_modify|
      new_program = @program.clone
      new_program[ins_to_modify] = swap(new_program[ins_to_modify])
      i = Interpreter.new
      i.load(new_program)
      i.run_no_dups
    end
    @program[ins] = swap(@program[ins])
    @program
  end

  def analyze_allowable_changes(program, run_order)
    run_order.select { |inst| program[inst].match?(/(nop|jmp)/) }
  end
  def swap(inst)
    return inst.sub("nop","jmp") if inst.include?("nop")
    return inst.sub("jmp","nop") if inst.include?("jmp")
    raise "this shouldn't be here."
  end

end
