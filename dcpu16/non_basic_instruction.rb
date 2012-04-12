module DCPU16
  class NonBasicInstruction
    attr_accessor :opcode, :a, :next_word_a

    def basic?
      false
    end

    def next_word_for_a?
      [0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x1E, 0x1F].include? @a
    end
  end
end
