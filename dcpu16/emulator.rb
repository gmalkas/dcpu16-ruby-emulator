require_relative './instruction_set'
require 'ostruct'

module DCPU16
  class Emulator
    attr_reader :memory, :pc, :sp, :overflow, :registers

    def initialize(path)
      initialize_registers
      load_program_from_file path
    end

    def run
      execute
    end

    def dump
      dump = Array.new
      @memory.each do |m|
        dump << m.unpack("H*")
      end

      dump.join " "
    end
    
    def registers_dump
      dump = Array.new
      @registers.each do |k, v|
        dump << k.to_s(16) + ": " + v.to_s(16)
      end
      dump.join " "
    end

    protected

    def load_program_from_file(path)
      @memory = Array.new

      File.open(path, "rb") do |f|
        until f.eof?
          @memory << f.read(2)
        end
      end

      @pc = 0
      @sp = 0xFFFF
    end

    def initialize_registers
      @registers = {
        0x00 => 0,
        0x01 => 0,
        0x02 => 0,
        0x03 => 0,
        0x04 => 0,
        0x05 => 0,
        0x06 => 0,
        0x07 => 0
      }
    end

    def execute
      instruction = parse_instruction next_word
      instruction.execute self
    end

    def next_word
      word = @memory[@pc].unpack("B*").first.to_i(2)
      @pc += 1
      word
    end

    def parse_instruction(word)
      opcode = word & 0xF

      if opcode == 0
        # Non-basic instruction
        opcode = (word >> 4) & 0x3F
        instruction = InstructionSet.fetch_non_basic_instruction opcode
        instruction.a = (word >> 10) & 0x3F
      else
        # Basic instruction
        instruction = InstructionSet.fetch_basic_instruction opcode
        instruction.a = (word >> 4) & 0x3F
        instruction.b = (word >> 10) & 0x3F
        instruction.next_word_a = next_word if instruction.next_word_for_a?
        instruction.next_word_b = next_word if instruction.next_word_for_b?
      end
      instruction
    end
  end
end
