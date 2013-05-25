require 'spec_helper'

describe Reru::Next do
  before(:all) do
    @value = 'some value'
    @target = Reru::Next.new(@value)
  end
  
  it "is a Reru::Event" do
    @target.is_a?(Reru::Event).should be_true
  end
  
  it "returns true to :next?" do
    @target.next?.should be_true
  end

  it "returns true to :value?" do
    @target.value?.should be_true
  end
  
  it "returns false to :eos?" do
    @target.eos?.should be_false
  end
  
  it "returns the value on :value" do
    @target.value.should === @value
  end
  
  it "calls :to_s on the value in its :to_s method" do
    @value.should_receive(:to_s).and_return('here we go')
    @target.to_s.should == 'here we go'
  end
  
  it "equals to other instances with the same value" do
    Reru::Next.new(1).should == Reru::Next.new(1)
  end
end