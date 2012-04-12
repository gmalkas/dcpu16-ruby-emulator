require_relative './instructions/set'
require_relative './instructions/add'
require_relative './instructions/sub'
require_relative './instructions/mul'
require_relative './instructions/div'
require_relative './instructions/mod'
require_relative './instructions/shl'
require_relative './instructions/shr'
require_relative './instructions/and'
require_relative './instructions/bor'
require_relative './instructions/xor'
require_relative './instructions/ife'
require_relative './instructions/ifn'
require_relative './instructions/ifg'
require_relative './instructions/ifb'
require_relative './instructions/jsr'

module DCPU16
  class InstructionSet
    @@basic_instructions = {
      0x1 => Instructions::Set,
      0x2 => Instructions::Add,
      0x3 => Instructions::Sub,
      0x4 => Instructions::Mul,
      0x5 => Instructions::Div,
      0x6 => Instructions::Mod,
      0x7 => Instructions::Shl,
      0x8 => Instructions::Shr,
      0x9 => Instructions::And,
      0xa => Instructions::Bor,
      0xb => Instructions::Xor,
      0xc => Instructions::Ife,
      0xd => Instructions::Ifn,
      0xe => Instructions::Ifg,
      0xf => Instructions::Ifb
    }

    @@non_basic_instructions = {
      0x1 => Instructions::Jsr
    }

    def self.fetch_basic_instruction(opcode)
      @@basic_instructions.fetch(opcode).new
    end
    
    def self.fetch_non_basic_instruction(opcode)
      @@non_basic_instructions.fetch(opcode).new
    end
  end
end
