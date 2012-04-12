require_relative '../value_set'
require_relative '../basic_instruction'

module DCPU16
  module Instructions
    class Div < BasicInstruction
      def initialize
        @opcode = 0x5
      end

      def execute(emulator)
        b = ValueSet.get emulator, @b, @next_word_b
        a = ValueSet.get emulator, @a, @next_word_a
        a_i = Memory.to_i a
        b_i = Memory.to_i b
        result = Memory.to_bin (a_i / b_i)
        if b_i == 0
          ValueSet.set emulator, @a, @next_word_a, Memory.to_bin(0)
          emulator.overflow = 0
        else
          ValueSet.set emulator, @a, @next_word_a, result
          emulator.overflow = ((a_i >> 16) / b_i) & 0xFFFF
        end
      end
    end
  end
end
