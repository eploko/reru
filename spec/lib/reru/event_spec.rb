require 'spec_helper'

describe Reru::Event do
  before(:all) do
    @target = Reru::Event.new
  end
  
  it "returns false to :next?, :value?, and :eos?" do
    [:next?, :value?, :eos?].each do |msg|
      @target.send(msg).should be_false
    end
  end
end