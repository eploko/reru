require 'spec_helper'

describe Reru::Stream do
  it "is a Reru::Source" do
    Reru::Stream.ancestors.include?(Reru::Source).should be_true
  end
  
  it "returns self on :to_stream" do
    s = Reru::Stream.new
    s.to_stream.should === s
  end
  
  it "return a new merging stream" do
    a = Reru::Stream.new
    b = Reru::Stream.new
    c = a.merge(b)
    c.should be_a Reru::Stream
    c.should_not == a
    c.should_not == b
  end
end