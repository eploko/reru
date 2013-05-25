require 'spec_helper'

describe Reru::Map do
  it "maps with a block" do
    emitter = ['a', 'x'].as_emitter
    result = []
    emitter.map{ |x| x.upcase }.perform{ |x| result << x }
    emitter.start
    result.should == ['A', 'X']
  end

  it "maps with a symbol" do
    emitter = ['b', 'y'].as_emitter
    result = []
    emitter.map(:upcase).perform{ |x| result << x }
    emitter.start
    result.should == ['B', 'Y']
  end
end