module DCPU16
  class BasicInstruction
    attr_accessor :opcode, :a, :b, :next_word_a, :next_word_b

    def basic?
      true
    end

    def next_word_for_a?
      next_word_for? @a
    end

    def next_word_for_b?
      next_word_for? @b
    end

    protected

    def next_word_for?(value)
      [0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x1E, 0x1F].include? value
    end
  end
end
