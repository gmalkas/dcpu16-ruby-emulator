module DCPU16
  class Memory
    def initialize(data)
      @ram = Array.new (0x10000 - data.size)
      @ram.insert 0, *data   
    end

    def fetch(index)
      @ram[index]
    end

    def fetch_integer(index)
      fetch(index).unpack("B*").first.to_i 2
    end

    def insert(index, value)
      @ram.insert(index, value)
    end

    def insert_integer(index, value)
      insert(index, [value].pack("S"))
    end
    
    def raw
      @ram
    end

    def self.to_i(word)
      word.unpack("B*").first.to_i 2
    end

    def self.to_bin(int)
      [int].pack("S>")
    end

    def self.to_bin_s(int)
      self.to_bin(int).unpack("B*").first
    end
  end
end
