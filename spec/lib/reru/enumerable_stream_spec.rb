require 'spec_helper'

describe Reru::EnumerableStream do
  it "is a Reru::Stream" do
    Reru::EnumerableStream.ancestors.include?(Reru::Stream).should be_true
  end
  
  it "raises ArgumentError if initialized w/o an enumerable" do
    expect { Reru::EnumerableStream.new }.to raise_error ArgumentError
  end

  it "raises ArgumentError if initialized w a non-enumerable" do
    expect { Reru::EnumerableStream.new(1) }.to raise_error ArgumentError
  end
  
  it "can be instantiated with an enumerable" do
    expect { Reru::EnumerableStream.new([]) }.to_not raise_error
  end
  
  context "when run" do
    it "emits all the enumerable values and an EOS" do
      target = Reru::EnumerableStream.new([1, 2, 3])
      target.should_receive(:emit).once.with(Reru::Next.new(1)).ordered
      target.should_receive(:emit).once.with(Reru::Next.new(2)).ordered
      target.should_receive(:emit).once.with(Reru::Next.new(3)).ordered
      target.should_receive(:emit).once.with(Reru::EOS).ordered
      target.run
    end
  end
end