require 'spec_helper'

describe Reru::Emitter do
  before(:each) do
    @emitter = Reru::Emitter.new
  end
  
  it "includes Reru::Sink" do
    Reru::Emitter.should include(Reru::Sink)
  end
  
  it "can be started" do
    expect { @emitter.start }.to_not raise_error
  end
  
  it "returns self on :start" do
    @emitter.start.should == @emitter
  end
end