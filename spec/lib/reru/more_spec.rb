require 'spec_helper'

describe Reru::More do
  before(:all) do
    @target = Reru::MORE
  end  

  it "is a singleton" do
    @target.class.should include(Singleton)
    expect { Reru::More.new }.to raise_error
  end
  
  it "is equal to other instances" do
    Reru::More.instance.should == Reru::MORE
    Reru::More.instance.should === Reru::MORE
  end
end