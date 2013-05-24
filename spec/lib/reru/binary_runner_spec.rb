require 'spec_helper'

describe Reru::BinaryRunner do
  before(:each) do
    @target = double('target')
    @arg = double('argument')    
  end
  
  it "runs the given method on the target" do
    @target.should_receive(:message).with(@arg)
    runner = Reru::BinaryRunner.new(:message)
    runner.run(@target, @arg)
  end
  
  it "runs the given block with the target" do
    block_called = false
    runner = Reru::BinaryRunner.new { |a, b|
      block_called = true
      a.should === @target
      b.should === @arg
    }
    runner.run(@target, @arg)
    block_called.should be_true
  end  
end

