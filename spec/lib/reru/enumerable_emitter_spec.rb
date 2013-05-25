require 'spec_helper'

describe Reru::EnumerableEmitter do
  it "is a Reru::Stream" do
    Reru::EnumerableEmitter.ancestors.include?(Reru::Emitter).should be_true
  end
  
  it "raises ArgumentError if initialized w/o an enumerable" do
    expect { Reru::EnumerableEmitter.new }.to raise_error ArgumentError
  end

  it "raises ArgumentError if initialized w/ a non-enumerable" do
    expect { Reru::EnumerableEmitter.new(1) }.to raise_error ArgumentError
  end
  
  it "can be instantiated with an enumerable" do
    expect { Reru::EnumerableEmitter.new([]) }.to_not raise_error
  end
  
  context "when started" do
    it "sinks all the enumerable values and an EOS" do
      target = Reru::EnumerableEmitter.new([1, 2, 3])
      target.should_receive(:sink).once.with(Reru::Next.new(1)).ordered
      target.should_receive(:sink).once.with(Reru::Next.new(2)).ordered
      target.should_receive(:sink).once.with(Reru::Next.new(3)).ordered
      target.should_receive(:sink).once.with(Reru::EOS).ordered
      target.start
    end
    
    it "returns self" do
      target = Reru::EnumerableEmitter.new([1, 2, 3])
      target.start.should == target
    end
  end
end