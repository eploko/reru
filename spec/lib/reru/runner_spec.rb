require 'spec_helper'

describe Reru::Runner do
  it "can be instantiated" do
    expect { Reru::Runner.new }.to_not raise_error
    expect { Reru::Runner.new(:plus) }.to_not raise_error
    expect { Reru::Runner.new{} }.to_not raise_error
    expect { Reru::Runner.new(:plus){} }.to_not raise_error
  end
end