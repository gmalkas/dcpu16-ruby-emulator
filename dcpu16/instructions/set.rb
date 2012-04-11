require_relative '../value_set'
require_relative '../basic_instruction'

module DCPU16
  module Instructions
    class Set < BasicInstruction

      def initialize
        @opcode = 0x1
      end

      def execute(emulator)
        value = ValueSet.get emulator, @b, @next_word_b
        ValueSet.set emulator, @a, @next_word_a, value
      end
    end
  end
end
