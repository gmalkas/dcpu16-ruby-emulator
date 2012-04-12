module DCPU16
  #
  # == Memory
  # 
  # Implements the RAM and provides some utility methods to use binary strings.
  #
  class Memory

    #
    # According to the specification, the RAM's size is 0x10000 words.
    # We load the program's instructions at address 0x0000.
    #
    # == Parameters
    # data::
    #   An array of binary strings, representing the program's instructions.
    #
    def initialize(data)
      @ram = Array.new (0x10000 - data.size)
      @ram.insert 0, *data   
    end

    def fetch(index)
      @ram[index]
    end

    # 
    # Replaces a word in memory.
    #
    # == Parameters
    # index::
    #   An integer representing the address of the word to replace in memory.
    # value::
    #   A binary string (or an Integer)
    #
    def set(index, value)
      value = Memory.to_bin(value) if value.is_a? Integer
      @ram[index] = value
    end
    
    def raw
      @ram
    end

    #
    # Converts a binary string into an integer.
    #
    # == Parameters
    #   word::
    #     The binary string to convert.
    #
    def self.to_i(word)
      word.unpack("B*").first.to_i 2
    end

    #
    # Converts an integer into a binary string.
    #
    # == Parameters
    #   int::
    #     The integer to convert.
    #
    def self.to_bin(int)
      [int].pack("S>")
    end

  end
end
