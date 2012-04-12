module DCPU16
  #
  # == Stack
  #
  # Implements the stack.
  # According to the specification, the stack starts in reverse order at address 0xFFFF in the RAM.
  #
  class Stack
    attr_reader :sp

    def initialize(emulator)
      @emulator = emulator
      reset
    end

    #
    # Pushes a value onto the stack.
    # According to the specification, it decrements SP then pushes the value.
    #
    # == Parameters
    # value::
    #   The binary string to push.    
    #
    def push(value)
      @sp -= 1
      @emulator.memory.set(@sp, value)
    end

    #
    # Removes the head of the stack and returns it.
    #
    # == Returns
    # A binary string
    #
    def pop
      value = peek
      @sp += 1
      value
    end

    #
    # Returns the head of the stack but does not remove it.
    #
    # == Returns
    # A binary string
    #
    def peek
      @emulator.memory.fetch(@sp)
    end

    def reset
      @sp = 0x10000
    end
  end
end
