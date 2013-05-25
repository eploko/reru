require 'spec_helper'

describe Reru::Receiver do
  context "when included" do
    class TestSink
      include Reru::Sink
    end
    
    class TestEndPoint
      include Reru::Receiver
      def protected_add_sink(sink); add_sink(sink); end
      def protected_activate; activate; end
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
    
    it "subscribes to sinks on :activate" do
      @end_point.protected_methods.should include(:activate)
      @end_point.protected_add_sink(@sink)
      @sink.should_receive(:add_receiver).once.with(@end_point)
      @end_point.protected_activate
    end
    
    it "dispatches events when :should_dispatch? return true" do
      @end_point.protected_add_sink(@sink)
      event = Reru::Next.new('here we go')
      @end_point.stub(:should_dispatch?).and_return(true)
      @end_point.should_receive(:dispatch).with(event)
      @end_point.receive(@sink, event)
    end

    it "doesn't dispatch events when :should_dispatch? return false" do
      @end_point.protected_add_sink(@sink)
      event = Reru::Next.new('here we go')
      @end_point.stub(:should_dispatch?).and_return(false)
      @end_point.should_not_receive(:dispatch)
      @end_point.receive(@sink, event)
    end
  end
end
