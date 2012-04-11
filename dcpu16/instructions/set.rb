require_relative '../basic_instruction'

module DCPU16
  module Instructions
    class Set < BasicInstruction

      def initialize
        @opcode = 0x1
      end

      def execute(emulator)
        value = case @b     
        when 0x1E
          emulator.memory[@next_word_b]
        when 0x1F
          @next_word_b
        end

        case @a
        when 0x00..0x07
          emulator.registers[@a] = value
        when 0x1e
          emulator.memory[@next_word_a] = value
        when 0x1f
          p "You tried to assign a literal value!"
        end
      end
    end
  end
end
