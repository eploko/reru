require 'spec_helper'

describe Reru::Once do
  it "emits an event only once" do
    xs = []
    once = Reru.once('y')
    once.perform { |x| xs << x }
    Reru.run
    xs.should == ['y']
  end
end