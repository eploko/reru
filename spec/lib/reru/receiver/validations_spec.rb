require 'spec_helper'

describe Reru::Receiver::Validations do
  it "is a module" do
    Reru::Receiver::Validations.is_a?(Module).should be_true
  end
  
  context "when included" do
    include Reru::Receiver::Validations
    
    before(:each) do
      class TestReceiver
        include Reru::Receiver
      end
      @receiver = TestReceiver.new
    end
    
    it "verifies a receiver is actually a receiver" do
      expect { validate_receiver('non-receiver') }.to raise_error ArgumentError
      expect { validate_receiver(@receiver) }.to_not raise_error
    end

    it "verifies a receiver implements :receive" do
      class NonConformingTestReceiver
      end
      expect { validate_receiver(NonConformingTestReceiver.new) }.to raise_error ArgumentError
      expect { validate_receiver(@receiver) }.to_not raise_error
    end    
  end
  
end
