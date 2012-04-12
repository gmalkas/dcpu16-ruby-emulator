require_relative '../value_set'
require_relative '../basic_instruction'

module DCPU16
  module Instructions
    class Ife < BasicInstruction
      def initialize
        @opcode = 0xc
      end

      def execute(emulator)
        b = ValueSet.get emulator, @b, @next_word_b
        a = ValueSet.get emulator, @a, @next_word_a
        if a != b
          emulator.skip_instruction
        end
      end
    end
  end
end

