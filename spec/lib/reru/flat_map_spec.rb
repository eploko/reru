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
    strings.start
    result.should == [10, 'x', 45, 'x', 'x', 1]
  end
end