require 'spec_helper'

describe Reru::EOS do
  before(:all) do
    @target = Reru::EOS
  end  
  
  it "is a Reru::Event" do
    @target.is_a?(Reru::Event).should be_true
  end

  it "returns false to :next?" do
    @target.next?.should be_false
  end

  it "returns false to :value?" do
    @target.value?.should be_false
  end
  
  it "returns true to :eos?" do
    @target.eos?.should be_true
  end
  
  it "is a singleton" do
    @target.class.include?(Singleton).should be_true
  end  
end
