DCPU-16 Ruby Emulator
=====================
This is a Ruby implementation of an emulator for the DCPU-16 platform.

Specification: Latest version is http://0x10c.com/doc/dcpu-16.txt, see +dcpu-16-specification.txt+ for the version used in this project.

How-to: add new instructions
============================
If you want to extend the current DCPU-16 specification and add your own instructions, you can simply create a new file in dcpu16/instructions and extend
NonBasicInstruction. You then have to implement the #execute method, add your instruction to the instruction set in +dcpu16/instruction_set.rb+ and you're good to go.

Caveats
=======
Each instruction leads to a new Instruction object (either BasicInstruction or NonBasicInstruction). A better implementation would use the Flyweight pattern (http://en.wikipedia.org/wiki/Flyweight_pattern)
to limit the number of instances. However, both BasicInstruction and NonBasicInstruction have intern states. One solution would be to pass this state as a parameter to the BasicInstruction#execute method, but
that implies heavy modifications to the code.
