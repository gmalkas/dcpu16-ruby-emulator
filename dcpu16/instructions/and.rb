require_relative '../value_set'
require_relative '../basic_instruction'

module DCPU16
  module Instructions
    class And < BasicInstruction
      def initialize
        @opcode = 0x9
      end

      def execute(emulator)
        b = ValueSet.get emulator, @b, @next_word_b
        a = ValueSet.get emulator, @a, @next_word_a
        a_i = Memory.to_i a
        b_i = Memory.to_i b
        result = Memory.to_bin (a_i & b_i)
        ValueSet.set emulator, @a, @next_word_a, result
      end
    end
  end
end
