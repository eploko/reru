require 'spec_helper'

describe Reru::Emitter::Validations do
  it "is a module" do
    Reru::Emitter::Validations.is_a?(Module)
  end
  
  context "when included" do
    include Reru::Emitter::Validations

    before(:each) do
      class TestEmitter
        include Reru::Emitter
        def emit(event); end
      end
      @emitter = TestEmitter.new
    end
    
    it "verifies an emitter is actually an emitter" do
      expect { validate_emitter('non-emitter') }.to raise_error ArgumentError
      expect { validate_emitter(@emitter) }.to_not raise_error
    end
  end
end