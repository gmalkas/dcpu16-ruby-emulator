# DCPU-16 Ruby Emulator

filename = ARGV.first
raise "Need a filename!" unless filename

File.open(filename, "rb") do |f|
  data = Array.new
  while (word = f.read(2))
    data << word.unpack("B*")
  end
  p data.join " "
end
