module DCPU16
  class Stack
    attr_reader :sp

    def initialize(emulator)
      @emulator = emulator
      reset
    end

    def push(value)
      @sp -= 1
      @emulator.memory.set(@sp, value)
    end

    def pop
      value = peek
      @sp += 1
      value
    end

    def peek
      @emulator.memory.fetch(@sp)
    end

    def reset
      @sp = 0x10000
    end
  end
end
