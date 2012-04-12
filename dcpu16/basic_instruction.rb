module DCPU16
  #
  # == BasicInstruction
  #
  # Implements some common functionalities for basic instructions.
  #
  # A basic instruction is a 16 bits unsigned word, and has the following structure (each character is a bit):
  #
  #   bbbbbbaaaaaaoooo
  #
  # oooo: the opcode
  # aaaaaa: the first value
  # bbbbbb: the second value
  #
  # For basic instructions, the opcode is between 0x1 and 0xF. See DCPU-16 specification for more details.
  #
  # == Example
  #
  # ASM: SET A, X
  # Binary: 000011 000000 0001
  #         bbbbbb aaaaaa oooo
  # 
  # == See also
  #
  # DCPU16::ValueSet for a mapping of value codes and their related meanings.
  #
  class BasicInstruction
    attr_accessor :opcode, :a, :b, :next_word_a, :next_word_b

    #
    # Determines whether the instruction is basic or not. Returns always true.
    #
    def basic?
      true
    end

    #
    # Returns true if the code value `a` refers to the word following the instruction.
    #
    # == Example
    #
    # According to the specification, when `a` is 0x1F, the value is the word following the instruction, interpreted as a literal value.
    #
    def next_word_for_a?
      next_word_for? @a
    end

    # Returns true if the code value `b` refers to the word following the instruction.
    #
    # == Example
    #
    # According to the specification, when `b` is 0x1F, the value is the word following the instruction, interpreted as a literal value.
    #
    def next_word_for_b?
      next_word_for? @b
    end

    protected

    def next_word_for?(value)
      # See DCPU16::ValueSet and DCPU-16 specification for more information about these values
      [0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x1E, 0x1F].include? value
    end
  end
end
