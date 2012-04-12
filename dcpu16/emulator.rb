require_relative './instruction_set'
require_relative './memory'
require_relative './stack'

module DCPU16

  ##
  # = Emulator
  #
  # Emulates the DCPU16.
  #
  # == Usage
  #
  #  emulator = DCPU16::Emulator.new "myfile.bin"
  #  emulator.run
  #  p emulator.memory_dump
  #
  class Emulator
    attr_reader :memory, :stack, :registers
    attr_accessor :pc, :overflow

    def initialize(path)
      initialize_registers
      load_program_from_file path
    end

    def sp
      @stack.sp
    end

    def run
      1.upto(100) { execute }
    end

    def memory_dump
      dump = Array.new
      @memory.raw.compact.each do |m|
        dump << m.unpack("H*")
      end

      dump.join " "
    end
    
    def registers_dump
      dump = Array.new
      @registers.each do |k, v|
        dump << @register_names[k] + ": " + v.unpack("H*").first
      end
      dump << "PC: " + @pc.to_s(16)
      dump << "Overflow: " + @overflow.to_s
      dump.join " | "
    end

    #
    # Skip the next instruction (including any 'next word' associated with the association).
    #
    def skip_instruction
      parse_instruction next_word
    end

    protected

    #
    # Reads the binary file, loads the instructions into the RAM, then initializes counters.
    #
    def load_program_from_file(path)
      data = Array.new

      File.open(path, "rb") do |f|
        until f.eof?
          data << f.read(2)
        end
      end

      @memory = Memory.new data
      @pc = 0
      @stack = Stack.new self
    end

    def initialize_registers
      @registers = {
        0x00 => Memory.to_bin(0),
        0x01 => Memory.to_bin(0),
        0x02 => Memory.to_bin(0),
        0x03 => Memory.to_bin(0),
        0x04 => Memory.to_bin(0),
        0x05 => Memory.to_bin(0),
        0x06 => Memory.to_bin(0),
        0x07 => Memory.to_bin(0)
      }

      @register_names = %w(A B C X Y Z I J)
    end

    #
    # Executes the next instruction.
    #
    def execute
      @overflow = 0
      instruction = parse_instruction next_word
      instruction.execute self
    end

    #
    # Reads the next word.
    #
    # == Returns
    # A binary string.
    #
    def next_word
      word = @memory.fetch(@pc)
      @pc += 1
      word
    end

    #
    # Parses the instruction, fetches the corresponding instruction instance, then sets its attributes
    # (including next words, if any of the instruction value codes refers to "next word")
    #
    # == Parameters
    # word::
    #   A binary string representing the instruction.
    #
    # == Returns
    # An instance of either a BasicInstruction's subclass or a NonBasicInstruction's subclass.
    #
    # == See also
    #
    # DCPU16::BasicInstruction
    # DCPU16::NonBasicInstruction
    #
    def parse_instruction(word)
      value = Memory.to_i word
      opcode = value & 0xF
      if opcode == 0
        # Non-basic instruction
        opcode = (value >> 4) & 0x3F
        instruction = InstructionSet.fetch_non_basic_instruction opcode
        instruction.a = (value >> 10) & 0x3F
        instruction.next_word_a = Memory.to_i(next_word) if instruction.next_word_for_a?
      else
        # Basic instruction
        instruction = InstructionSet.fetch_basic_instruction opcode
        instruction.a = (value >> 4) & 0x3F
        instruction.b = (value >> 10) & 0x3F
        instruction.next_word_a = Memory.to_i(next_word) if instruction.next_word_for_a?
        instruction.next_word_b = Memory.to_i(next_word) if instruction.next_word_for_b?
      end
      instruction
    end
  end
end
