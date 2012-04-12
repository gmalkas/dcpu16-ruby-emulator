module DCPU16
  class ValueSet
    #
    # Returns the corresponding value.
    # `code` and `next_word` must be integers
    #
    def self.get(emulator, code, next_word)
        case code     
        when 0x00..0x07
          emulator.registers[codeb]
        when 0x08..0x0F
          emulator.memory.fetch(emulator.registers[code - 0x08])
        when 0x10..0x17
          emulator.memory.fetch(next_word + emulator.registers[code - 0x10])
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
          emulator.memory.fetch(next_word)
        when 0x1F
          next_word
        when 0x20..0x3f
          code - 0x20
        else
          raise "Unknown value: #{code.to_s(16)}!"
        end
    end

    def self.set(emulator, code, next_word, value)
        case code
        when 0x00..0x07
          emulator.registers[code] = Memory.to_bin(value)
        when 0x08..0x0F
          emulator.memory[emulator.registers[code - 0x08]] = value
        when 0x10..0x17
          emulator.memory[next_word + emulator.registers[code - 0x10]] = value
        when 0x1A
          emulator.stack.push value
        when 0x1b
          emulator.sp = value
        when 0x1c
          emulator.pc = value
        when 0x1d
          p "You tried to assign 0!"
        when 0x1E
          emulator.memory[next_word] = value
        when 0x1F
          p "You tried to assign a literal value!"
        when 0x20..0x3f
          p "You tried to assign a literal value!"
        end
    end
  end

end
