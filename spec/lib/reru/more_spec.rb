require 'spec_helper'

describe Reru::More do
  context "when returned from Reru.more" do
    it "returns true on :more?" do
      Reru.more.more?.should be_true
    end

    it "equals to other instances" do
      Reru.more.should == Reru.more
    end

    it "isn't equal to Reru.enough" do
      Reru.more.should_not == Reru.enough
    end
  end

  context "when returned from Reru.enough" do
    it "returns false on :more?" do
      Reru.enough.more?.should be_false
    end

    it "equals to other instances" do
      Reru.enough.should == Reru.enough
    end

    it "isn't equal to Reru.more" do
      Reru.enough.should_not == Reru.more
    end
  end
end