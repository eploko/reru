require 'spec_helper'

describe Reru::IO::Reader do
  it "spits what it reads down the stream" do
    StringIO.open("hello world\nhere we go!") do |input|
      reader = Reru::IO::Reader.new(input)
      xs = []
      reader.perform { |x| xs << x }
      Reru.run
      xs.should == ["hello world\n", "here we go!"]
    end
  end
  
  it "stops reading if told so" do
    StringIO.open('x' * 2_000_000) do |input|
      reader = Reru.read(input)
      xs = []
      reader.perform { |x| 
        xs << x 
        reader.stop
      }
      Reru.run
      xs.should == ['x' * 1_000_000]
    end
  end
end