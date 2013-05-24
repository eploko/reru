require 'spec_helper'

describe Reru::CoreExt::Enumerable do
  it "is a Module" do
    Reru::CoreExt::Enumerable.should be_a Module
  end
  
  context "when included" do
    before(:all) do
      class TestTarget
        include Reru::CoreExt::Enumerable
      end
      @target = TestTarget.new
    end    
    
    it "provides the as_stream method" do
      @target.should respond_to :as_stream
    end  
    
    it "is automatically included into Enumerable" do
      Enumerable.should include Reru::CoreExt::Enumerable
    end
    
    it "helps convert an Enumerable to a Reru::Stream" do
      [].as_stream.should be_a Reru::Stream
    end
  end
end
