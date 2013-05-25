require 'spec_helper'

describe Reru::Sink::Validations do
  it "is a module" do
    Reru::Sink::Validations.is_a?(Module)
  end
  
  context "when included" do
    include Reru::Sink::Validations

    before(:each) do
      class TestSink
        include Reru::Sink
        def emit(event); end
      end
      @sink = TestSink.new
    end
    
    it "verifies an sink is actually an sink" do
      expect { validate_sink('non-sink') }.to raise_error ArgumentError
      expect { validate_sink(@sink) }.to_not raise_error
    end
  end
end