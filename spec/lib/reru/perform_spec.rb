require 'spec_helper'

describe Reru::Perform do
  it "performs the given block and propagates the data further w/o any change" do
    initial = ['a','b']
    emitter = initial.as_emitter
    s1 = []
    s2 = []
    emitter.perform{ |x| 
      s1 << x.upcase 
    }.perform{ |x| 
      s2 << x 
    }
    Reru.run
    s1.should == ['A', 'B']
    s2.should == initial
  end
  
  it "logs values" do
    emitter = ['hello', 'world'].as_emitter
    emitter.log
    file = StringIO.new('')
    begin
      orig_stdout = $stdout
      $stdout = file
      Reru.run
    ensure
      $stdout = orig_stdout
    end
    file.rewind
    file.read.should == "hello\nworld\n"
    file.close        
  end
end