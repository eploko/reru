require 'spec_helper'

describe Reru::Sink do
  it "is a module" do
    Reru::Sink.is_a?(Module).should be_true
  end
  
  context "when included" do
    class TestSink
      include Reru::Sink
      
      def receiver_added(receiver)
      end
    end
    
    class TestReceiver
      include Reru::Receiver
      
      def receive(sink, event)
      end
    end

    before(:each) do
      @sink = TestSink.new
      @receiver = TestReceiver.new
    end
    
    it "can add receivers" do
      expect { @sink.add_receiver(@receiver) }.to_not raise_error
    end

    it "calls :receiver_added after a new receiver is added" do
      @sink.should_receive(:receiver_added).once
      @sink.add_receiver(@receiver)
    end
    
    it "verifies only Reru::Receivers are added as receivers" do
      expect { @sink.add_receiver('non-receiver') }.to raise_error ArgumentError
      expect { @sink.add_receiver(@receiver) }.to_not raise_error
    end

    it "emits events to its receivers" do
      @sink.add_receiver(@receiver)
      receiver2 = TestReceiver.new
      @sink.add_receiver(receiver2)
      event = Reru::Next.new('here we go')
      @receiver.should_receive(:receive).once.with(@sink, event)
      receiver2.should_receive(:receive).once.with(@sink, event)
      @sink.emit(event)
    end
    
    it "allows emitting only of Reru::Events" do
      expect { @sink.emit('non-event') }.to raise_error ArgumentError
      expect { @sink.emit(Reru::Next.new('here we go')) }.to_not raise_error
    end
  end
end