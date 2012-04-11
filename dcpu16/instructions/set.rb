require_relative '../basic_instruction'

module DCPU16
  module Instructions
    class Set < BasicInstruction

      def initialize
        @opcode = 0x1
      end

      def execute(emulator)
        value = case @b     
        when 0x00..0x07
          emulator.registers[@b]
        when 0x08..0x0F
          emulator.memory[emulator.registers[@b - 0x08]]
        when 0x10..0x17
          emulator.memory[@next_word_b + emulator.registers[@b - 0x10]]
        when 0x1b
          emulator.sp
        when 0x1c
          emulator.pc
        when 0x1d
          0
        when 0x1E
          emulator.memory[@next_word_b]
        when 0x1F
          @next_word_b
        when 0x20..0x3f
          @b - 0x20
        else
          raise "Unknown value: #{@b.to_s(16)}!"
        end

        case @a
        when 0x00..0x07
          emulator.registers[@a] = value
        when 0x08..0x0F
          emulator.memory[emulator.registers[@a - 0x08]] = value
        when 0x10..0x17
          emulator.memory[@next_word_a + emulator.registers[@a - 0x10]] = value
        when 0x1b
          emulator.sp = value
        when 0x1c
          emulator.pc = value
        when 0x1d
          p "You tried to assign 0!"
        when 0x1E
          emulator.memory[@next_word_a] = value
        when 0x1F
          p "You tried to assign a literal value!"
        when 0x20..0x3f
          p "You tried to assign a literal value!"
        end

      end
    end
  end
end
