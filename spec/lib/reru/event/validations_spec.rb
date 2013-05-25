require 'spec_helper'

describe Reru::Event::Validations do
  it "is a module" do
    Reru::Event::Validations.is_a?(Module).should be_true
  end
  
  context "when included" do
    include Reru::Event::Validations

    it "validates an event is actually an event" do
      expect { validate_event('non-event') }.to raise_error ArgumentError
      expect { validate_event(Reru::Next.new('here we go')) }.to_not raise_error
    end    
  end
end