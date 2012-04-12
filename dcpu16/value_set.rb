module DCPU16
  class ValueSet
    #
    # Returns the corresponding value as a binary string.
    # `code` and `next_word` must be integers
    #
    def self.get(emulator, code, next_word)
        case code     
        when 0x00..0x07
          emulator.registers[code]
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
          Memory.to_bin next_word
        when 0x20..0x3f
          Memory.to_bin (code - 0x20)
        else
          raise "Unknown value: #{code.to_s(16)}!"
        end
    end

    #
    # `code` and `next_word` must be integers
    # `value` must be a binary string
    #
    def self.set(emulator, code, next_word, value)
        case code
        when 0x00..0x07
          emulator.registers[code] = value
        when 0x08..0x0F
          emulator.memory.insert(emulator.registers[code - 0x08], value)
        when 0x10..0x17
          emulator.memory.insert(next_word + emulator.registers[code - 0x10], value)
        when 0x1A
          emulator.stack.push value
        when 0x1b
          emulator.sp = value
        when 0x1c
          emulator.pc = value
        when 0x1d
          p "You tried to assign 0!"
        when 0x1E
          emulator.memory.insert(next_word, value)
        when 0x1F
          p "You tried to assign a literal value!"
        when 0x20..0x3f
          p "You tried to assign a literal value!"
        end
    end
  end

end
