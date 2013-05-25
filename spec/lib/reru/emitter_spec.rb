require 'spec_helper'

describe Reru::Emitter do
  it "is a module" do
    Reru::Emitter.is_a?(Module).should be_true
  end
  
  context "when included" do
    class TestEmitter
      include Reru::Emitter
      
      def receiver_added(receiver)
      end
    end
    
    class TestReceiver
      include Reru::Receiver
      
      def receive(emitter, event)
      end
    end

    before(:each) do
      @emitter = TestEmitter.new
      @receiver = TestReceiver.new
    end
    
    it "can add receivers" do
      expect { @emitter.add_receiver(@receiver) }.to_not raise_error
    end

    it "calls :receiver_added after a new receiver is added" do
      @emitter.should_receive(:receiver_added).once
      @emitter.add_receiver(@receiver)
    end
    
    it "verifies only Reru::Receivers are added as receivers" do
      expect { @emitter.add_receiver('non-receiver') }.to raise_error ArgumentError
      expect { @emitter.add_receiver(@receiver) }.to_not raise_error
    end

    it "verifies a receiver implements :receive" do
      class NonConformingTestReceiver
        include Reru::Receiver
      end
      expect { @emitter.add_receiver(NonConformingTestReceiver.new) }.to raise_error ArgumentError
      expect { @emitter.add_receiver(@receiver) }.to_not raise_error
    end
    
    it "emits events to its receivers" do
      @emitter.add_receiver(@receiver)
      receiver2 = TestReceiver.new
      @emitter.add_receiver(receiver2)
      event = Reru::Next.new('here we go')
      @receiver.should_receive(:receive).once.with(@emitter, event)
      receiver2.should_receive(:receive).once.with(@emitter, event)
      @emitter.emit(event)
    end
    
    it "allows emitting only of Reru::Events" do
      expect { @emitter.emit('non-event') }.to raise_error ArgumentError
      expect { @emitter.emit(Reru::Next.new('here we go')) }.to_not raise_error
    end
  end
end