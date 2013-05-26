require 'spec_helper'

describe Reru::Emitter do
  before(:each) do
    @emitter = Reru::Emitter.new
  end
  
  it "includes Reru::Sink" do
    Reru::Emitter.should include(Reru::Sink)
  end
  
  it "can run a tick" do
    expect { @emitter.tick }.to_not raise_error
  end
  
  it "returns Reru.enough on :tick" do
    @emitter.tick.should == Reru.enough
  end
  
  it "adds itself to the default run loop on initialization" do
    Reru.run_loop.emitters.should include @emitter
  end
  
  it "accepts a run loop in new" do
    run_loop = Reru::RunLoop.new
    emitter = Reru::Emitter.new(run_loop)
    emitter.run_loop.should === run_loop
  end
end