require 'spec_helper'

describe Reru::Runner do
  it "raises error if instantiated without either a method name or a block" do
    expect { Reru::Runner.new }.to raise_error ArgumentError
  end
  
  it "raises error if both a method name and a block are given" do
    expect { Reru::Runner.new(:plus) { } }.to raise_error ArgumentError
  end

  it "instantiates with only a method name" do
    expect { Reru::Runner.new(:plus) }.to_not raise_error
  end

  it "instantiates with only a block" do
    expect { Reru::Runner.new { } }.to_not raise_error
  end
end