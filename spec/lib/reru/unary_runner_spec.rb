require 'spec_helper'

describe Reru::UnaryRunner do
  before(:each) do
    @target = double('target')
  end

  it "runs the given method on the target" do
    @target.should_receive(:message)
    runner = Reru::UnaryRunner.new(:message)
    runner.run(@target)
  end
  
  it "runs the given block with the target" do
    block_called = false
    runner = Reru::UnaryRunner.new { |x|
      block_called = true
      x.should === @target
    }
    runner.run(@target)
    block_called.should be_true
  end
end