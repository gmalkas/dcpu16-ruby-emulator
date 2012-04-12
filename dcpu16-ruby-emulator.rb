# DCPU-16 Ruby Emulator

require_relative './dcpu16/emulator'

filename = ARGV.first
raise "Need a filename!" unless filename

emulator = DCPU16::Emulator.new filename
emulator.run
p emulator.registers_dump
p emulator.memory_dump
