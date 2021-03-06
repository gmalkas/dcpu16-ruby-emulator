require_relative '../value_set'
require_relative '../basic_instruction'

module DCPU16
  module Instructions
    class Ifg < BasicInstruction
      def initialize
        @opcode = 0xe
      end

      def execute(emulator)
        b = ValueSet.get emulator, @b, @next_word_b
        a = ValueSet.get emulator, @a, @next_word_a
        a_i = Memory.to_i a
        b_i = Memory.to_i b
        if a_i <= b_i
          emulator.skip_instruction
        end
      end
    end
  end
end


