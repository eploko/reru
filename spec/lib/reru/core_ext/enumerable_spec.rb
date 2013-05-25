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
    
    it "provides the as_emitter method" do
      @target.should respond_to :as_emitter
    end  
    
    it "is automatically included into Enumerable" do
      Enumerable.should include Reru::CoreExt::Enumerable
    end
    
    it "helps convert an Enumerable to a Reru::Emitter" do
      [].as_emitter.should be_a Reru::Emitter
    end
  end
end
