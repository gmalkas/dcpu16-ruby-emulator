module DCPU16
  class ValueSet
    #
    # Returns the corresponding value.
    #
    def self.get(emulator, code, next_word)
        case code     
        when 0x00..0x07
          emulator.registers[codeb]
        when 0x08..0x0F
          emulator.memory[emulator.registers[code - 0x08]]
        when 0x10..0x17
          emulator.memory[next_word + emulator.registers[code - 0x10]]
        when 0x18
          emulator.stack.pop
        when 0x19
          emulator.stack.peek
        when 0x1b
          emulator.sp
        when 0x1c
          emulator.pc
        when 0x1d
          0
        when 0x1E
          emulator.memory[next_word]
        when 0x1F
          next_word
        when 0x20..0x3f
          code - 0x20
        else
          raise "Unknown value: #{code.to_s(16)}!"
        end
    end
  end

end
