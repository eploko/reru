require 'spec_helper'

describe Reru::RunLoop do
  before(:each) do
    @run_loop = Reru::RunLoop.new
    Reru.run_loop = @run_loop
    @emitter = Reru::Emitter.new
  end

  context "in Reru module" do
    it "adds the run method" do
      Reru.should respond_to(:run)
    end

    it "adds the run_loop method" do
      Reru.should respond_to(:run_loop)
    end
    
    it "returns a Reru::RunLoop from the run_loop method" do
      Reru.run_loop.should be_a(Reru::RunLoop)      
    end
  end
    
  context "when instantiated" do
    
    it "can be ran" do
      @run_loop.should respond_to(:run)
      expect { @run_loop.run }.to_not raise_error
    end
  
    it "keeps track of added emitters" do
      @run_loop.should respond_to(:emitters)
      @run_loop.emitters.should == [@emitter]
    end    
    
    it "allows an emitter to add itself" do
      @run_loop.should respond_to(:add_emitter)
    end
    
    it "should check that an emitter is actually an emmitter on addition" do
      expect { @run_loop.add_emitter('non-emitter') }.to raise_error ArgumentError
      expect { @run_loop.add_emitter(@emitter) }.to_not raise_error
    end
  end
  
  context "after run" do
    it "has no emitters left" do
      @run_loop.emitters.size.should > 0
      @run_loop.run
      @run_loop.emitters.size.should == 0
    end
  end
end
