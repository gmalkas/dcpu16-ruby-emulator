require_relative './instruction_set'
require_relative './memory'
require_relative './stack'
require 'ostruct'

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
  #  p emulator.dump
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
      1.upto(3) { execute }
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
        dump << k.to_s(16) + ": " + v.unpack("H*").first
      end
      dump.join " | "
    end

    def skip_instruction
      parse_instruction next_word
    end

    protected

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
    end

    def execute
      @overflow = 0
      instruction = parse_instruction next_word
      instruction.execute self
    end

    def next_word
      word = @memory.fetch(@pc)
      @pc += 1
      word
    end

    def parse_instruction(word)
      value = Memory.to_i word
      opcode = value & 0xF

      if opcode == 0
        # Non-basic instruction
        opcode = (value >> 4) & 0x3F
        instruction = InstructionSet.fetch_non_basic_instruction opcode
        instruction.a = (value >> 10) & 0x3F
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
