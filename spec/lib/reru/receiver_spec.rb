require 'spec_helper'

describe Reru::Receiver do
  context "when included" do
    class TestSink
      include Reru::Sink
    end
    
    class TestEndPoint
      include Reru::Receiver
      def protected_add_sink(sink); add_sink(sink); end
      def protected_subscribe; subscribe; end
    end
    
    class TestReceiver
      include Reru::Receiver
    end
    
    before(:each) do
      @sink = TestSink.new
      @end_point = TestEndPoint.new
      @receiver = TestReceiver.new
    end
    
    it "adds sinks" do
      expect { @end_point.protected_add_sink(@sink) }.to_not raise_error
    end    
    
    it "raises on adding a non-sink" do
      expect { @end_point.protected_add_sink('non-sink') }.to raise_error ArgumentError
    end
    
    it "raises on duplicate sinks" do
      expect { @end_point.protected_add_sink(@sink) }.to_not raise_error
      expect { @end_point.protected_add_sink(@sink) }.to raise_error ArgumentError
    end
    
    it "provides a :receive implementation" do
      @end_point.should respond_to(:receive)
    end
    
    it "subscribes to the sink when it's added" do
      @sink.should_receive(:add_receiver).once.with(@end_point)
      @end_point.protected_add_sink(@sink)
    end
    
    it "dispatches events" do
      @end_point.protected_add_sink(@sink)
      event = Reru::Next.new('here we go')
      @end_point.should_receive(:dispatch).with(event)
      @end_point.receive(@sink, event)
    end
  end
end
