require_relative './instructions/set'
require_relative './instructions/add'
require_relative './instructions/sub'

module DCPU16
  class InstructionSet
    @@basic_instructions = {
      0x1 => Instructions::Set,
      0x2 => Instructions::Add,
      0x3 => Instructions::Sub
    }

    @@non_basic_instructions = {

    }

    def self.fetch_basic_instruction(opcode)
      @@basic_instructions.fetch(opcode).new
    end
    
    def self.fetch_non_basic_instruction(opcode)
      @@non_basic_instructions.fetch(opcode).new
    end
  end
end
