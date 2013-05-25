require 'spec_helper'

describe Reru::Never do
  it "emits EOS" do
    xs = []
    never = Reru.never
    never.perform { |x| xs << 'y' }
    never.start
    xs.should == []
  end
end