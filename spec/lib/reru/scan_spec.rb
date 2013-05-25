require 'spec_helper'

describe Reru::Scan do
  before(:each) do
    @emitter = [3, 8].as_emitter
  end
  
  it "scans with a block" do
    bs = []
    sums = []
    @emitter.scan(2) { |a, b| 
      bs << b
      a + b 
    }.perform { |sum| 
      sums << sum
    }
    @emitter.start
    bs.should == [3, 8]
    sums.should == [5, 13]
  end

  it "scans with a symbol" do
    bs = []
    sums = []
    @emitter.scan(2, :*).perform { |sum| 
      sums << sum
    }
    @emitter.start
    sums.should == [6, 48]
  end
end
