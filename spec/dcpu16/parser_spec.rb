require_relative '../../dcpu16/parser'

# === spec/examples/dcpu16_example.hexdump ===
# 0000000: 7c01 0030 7de1 1000 0020 7803 1000 c00d  |..0}.... x.....
# 0000010: 7dc1 001a a861 7c01 2000 2161 2000 8463  }....a|. .!a ..c
# 0000020: 806d 7dc1 000d 9031 7c10 0018 7dc1 001a  .m}....1|...}...
# 0000030: 9037 61c1 7dc1 001a 0000 0000 0000 0000  .7a.}...........
# === end ===
#
# === Binary ===
# 0111110000000001 0000000000110000 0111110111100001 0001000000000000
# 0000000000100000 0111100000000011 0001000000000000 1100000000001101
# 0111110111000001 0000000000011010 1010100001100001 0111110000000001
# 0010000000000000 0010000101100001 0010000000000000 1000010001100011
# 1000000001101101 0111110111000001 0000000000001101 1001000000110001
# 0111110000010000 0000000000011000 0111110111000001 0000000000011010
# 1001000000110111 0110000111000001 0111110111000001 0000000000011010
# 0000000000000000 0000000000000000 0000000000000000 0000000000000000
# === end ===

module DCPU16
  describe Parser do

    let(:filepath) {
      File.join(File.dirname(__FILE__), "../examples/dcpu16_example.bin")
    }

    let(:source) { File.open(filepath, "rb") }

    subject { Parser.new source }

    after do
      source.close
    end

    it "is initialized with a source" do
      subject.source.should == source
    end

    describe "#next_instruction" do
      it "reads the next instruction" do
        instruction = subject.next_instruction
        instruction.opcode.should == "0001"
        instruction.a.should == "000000"
        instruction.b.should == "011111"
      end
    end

    describe "#done?"do
      it "returns true if the source has been parsed" do
        subject.source.read
        subject.done?.should be_true
      end
    end
  end
end
