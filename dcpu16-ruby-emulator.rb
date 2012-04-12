# DCPU-16 Ruby Emulator

require_relative './dcpu16/emulator'

filename = ARGV.first
raise "Need a filename!" unless filename

emulator = DCPU16::Emulator.new filename
emulator.run
p emulator.registers_dump
p emulator.memory_dump

# File.open(filename, "rb") do |f|
#   data = Array.new
#   while (word = f.read(2))
#     data << word.unpack("B*")
#   end
#   p data.join " "
# end
