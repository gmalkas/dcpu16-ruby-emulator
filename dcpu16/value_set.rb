module DCPU16

  #
  # == ValueSet
  #
  # Encapsulates the mapping between hexadecimal codes and their corresponding meanings (RAM, Registers, etc).
  #
  class ValueSet
    #
    # Determines the value associated with the code.
    #
    # == Example
    #
    # According to the specification, the codes between 0x00 and 0x07 stand for the value of the corresponding register.
    # E.g: 0x01 => B
    #      0x07 => J
    #
    # == Parameters
    # emulator::
    #   An instance of DCPU16::Emulator
    # code::
    #   The hexadecimal code of the value (must be an Integer)
    # next_word::
    #   The hexadecimal value of the word related to the value (must be an Integer).
    #   This parameter is only necessary in some cases (see comments below and the DCPU-16 specification for details).
    #
    # == Returns
    #   A binary string
    #
    def self.get(emulator, code, next_word)
      case code     
      when 0x00..0x07 # Register
        emulator.registers[code]
      when 0x08..0x0F # [Register]
        emulator.memory.fetch(Memory.to_i(emulator.registers[code - 0x08]))
      when 0x10..0x17 # [Next word + Register]
        emulator.memory.fetch(next_word + Memory.to_i(emulator.registers[code - 0x10]))
      when 0x18 # POP
        emulator.stack.pop
      when 0x19 # PEEK
        emulator.stack.peek
      when 0x1b # SP
        Memory.to_bin emulator.sp
      when 0x1c # PC
        Memory.to_bin emulator.pc
      when 0x1d # 0verflow
        Memory.to_bin emulator.overflow
      when 0x1E # [Next word]
        emulator.memory.fetch(next_word)
      when 0x1F # Next word (literal)
        Memory.to_bin next_word
      when 0x20..0x3f # Literal
        Memory.to_bin (code - 0x20)
      else
        raise "Unknown value: #{code.to_s(16)}!"
      end
    end

    #
    #  Determines the location associated with the code, and changes its value accordingly.
    #
    #  == Parameters
    #  emulator::
    #    An instance of DCPU16::Emulator
    # code::
    #   The hexadecimal code of the value (must be an Integer)
    # next_word::
    #   The hexadecimal value of the word related to the value (must be an Integer)
    #   This parameter is only necessary in some cases (see comments below and the DCPU-16 specification for details).
    # value::
    #   The new value (a binary string)
    #
    def self.set(emulator, code, next_word, value)
      case code
      when 0x00..0x07 # Register
        emulator.registers[code] = value
      when 0x08..0x0F # [Register]
        emulator.memory.set(Memory.to_i(emulator.registers[code - 0x08]), value)
      when 0x10..0x17 # [Next word + Register]
        emulator.memory.set(next_word + Memory.to_i(emulator.registers[code - 0x10]), value)
      when 0x1A # PUSH
        emulator.stack.push value
      when 0x1b # SP
        emulator.sp = Memory.to_i value
      when 0x1c # PC
        emulator.pc = Memory.to_i value
      when 0x1d # 0verflow
        emulator.overflow = Memory.to_i value
      when 0x1E # [Next word]
        emulator.memory.set(next_word, value)
      when 0x1F # Next word (literal)
        p "You tried to assign a literal value!"
      when 0x20..0x3f # Literal
        p "You tried to assign a literal value!"
      end
    end
  end

end
