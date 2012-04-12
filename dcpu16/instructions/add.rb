require_relative '../value_set'
require_relative '../basic_instruction'

module DCPU16
  module Instructions
    class Add < BasicInstruction
      def initialize
        @opcode = 0x2
      end

      def execute(emulator)
        b = ValueSet.get emulator, @b, @next_code_b
        a = ValueSet.get emulator, @a, @next_code_a
        result = (a + b) & 0xFFFF
      end
    end
  end
end
