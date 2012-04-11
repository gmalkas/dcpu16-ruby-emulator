require 'ostruct'

module DCPU16
  class Parser
    attr_reader :source

    # Creates a new parser with the given source.
    # Must be a read-enabled instance of IO.
    def initialize(source)
      @source = source
    end

    def next_instruction
      return if done?
      word = source.read(2).unpack("B*").first
      b = word.slice(0..5)
      a = word.slice(6..11)
      opcode = word.slice(12..15)
      OpenStruct.new opcode: opcode, a: a, b: b
    end

    def done?
      @source.eof?
    end

  end
end
