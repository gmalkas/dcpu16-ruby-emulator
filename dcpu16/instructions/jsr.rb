require_relative '../value_set'
require_relative '../non_basic_instruction'

module DCPU16
  module Instructions
    class Jsr < NonBasicInstruction

      def initialize
        @opcode = 0x1
      end

      def execute(emulator)
        dest = ValueSet.get emulator, @a, @next_word_a
        emulator.stack.push emulator.pc
        emulator.pc = Memory.to_i dest 
      end
    end
  end
end
