require 'spec_helper'

describe Reru::FlatMap do
  it "maps with a block" do
    strings = ['10', '', '45', '', '', '1'].as_emitter
    result = []
    strings.flat_map{ |str| 
      unless str.empty?
        str.to_i
      else
        Reru::once('x')
      end
    }.perform{ |x|
      result << x
    }
    Reru.run
    result.size.should == 6
    result.count(10).should == 1
    result.count(45).should == 1
    result.count(1).should == 1
    result.count('x').should == 3
  end
end