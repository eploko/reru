require 'spec_helper'

describe Reru::Enough do
  before(:all) do
    @target = Reru::ENOUGH
  end  

  it "is a singleton" do
    @target.class.should include(Singleton)
    expect { Reru::ENOUGH.new }.to raise_error
  end
  
  it "is equal to other instances" do
    Reru::Enough.instance.should == Reru::ENOUGH
    Reru::Enough.instance.should === Reru::ENOUGH
  end
end