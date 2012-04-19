#! /usr/bin/env ruby
# DCPU-16 Ruby Emulator

require_relative './dcpu16/emulator'

if ARGV.size != 2
  puts "Format: dcpu16-ruby-emulator filename number_of_instructions"
  exit false
end

filename, number_of_instructions = *ARGV

emulator = DCPU16::Emulator.new filename
emulator.run number_of_instructions.to_i
p emulator.registers_dump
p emulator.memory_dump
