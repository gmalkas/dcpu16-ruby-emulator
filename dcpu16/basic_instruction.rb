module DCPU16
  class BasicInstruction
    attr_accessor :opcode, :a, :b, :next_word_a, :next_word_b

    def basic?
      @opcode != 0
    end

    def next_word_for_a?
      next_word_for? @a
    end

    def next_word_for_b?
      next_word_for? @b
    end

    protected

    def next_word_for?(value)
      [0x1E, 0x1F].include? value
    end
  end
end
