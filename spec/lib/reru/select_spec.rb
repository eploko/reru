require 'spec_helper'

describe Reru::Select do
  it "selects with a block" do
    emitter = ['a', '', '', 'b'].as_emitter
    result = []
    emitter.select{ |x| !x.empty? }.perform{ |x| result << x }
    Reru.run
    result.should == ['a', 'b']
  end  
  
  it "selects with a symbol" do
    emitter = ['a', '', '', 'b'].as_emitter
    result = []
    emitter.select(:empty?).perform{ |x| result << x }
    Reru.run
    result.should == ['', '']
  end  
end