module DCPU16
  class Stack
    attr_reader :sp

    def initialize(emulator)
      @emulator = emulator
      @sp = 0xFFFF
    end

    def push(value)
      emulator.memory.insert(@sp, value)
      @sp -= 1
    end

    def pop
      value = peek
      @sp += 1
      value
    end

    def peek
      emulator.memory.fetch(@sp)
    end

    def reset
      @sp = 0xFFFF
    end
  end
end
