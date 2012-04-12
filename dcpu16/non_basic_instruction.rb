module DCPU16
  #
  # = NonBasicInstruction
  #
  # Implements some common functionalities for non basic instructions.
  #
  # A non basic instruction is a 16 bits unsigned word, and has the following structure (each character is a bit):
  #
  #   aaaaaaoooooo0000
  #
  # oooooo: the opcode
  # aaaaaa: the value associated with the instruction
  #
  # For non basic instructions, the opcode is 6 bits long (versus 4 for basic instructions).
  # See DCPU-16 specification for more details.
  #
  # == Example
  #
  # Given that 'else' is a label associated with the address 0x3, then:
  #
  # ASM: JSR else
  # Binary: 000011 000001 0000
  #         aaaaaa oooooo 
  # 
  # == See also
  #
  # DCPU16::ValueSet for a mapping of value codes and their related meanings.
  #
  class NonBasicInstruction
    attr_accessor :opcode, :a, :next_word_a

    #
    # Determines whether the instruction is basic or not. Returns always false.
    #
    def basic?
      false
    end

    #
    # Returns true if the code value `a` refers to the word following the instruction.
    #
    # == Example
    #
    # According to the specification, when `a` is 0x1F, the value is the word following the instruction, interpreted as a literal value.
    #
    def next_word_for_a?
      # See DCPU16::ValueSet and DCPU-16 specification for more information about these values
      [0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x1E, 0x1F].include? @a
    end
  end
end
