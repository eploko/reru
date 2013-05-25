require 'spec_helper'

describe Reru::Receiver do
  context "when included" do
    class TestEmitter
      include Reru::Emitter
    end
    
    class TestEndPoint
      include Reru::Receiver
      def protected_add_emitter(emitter); add_emitter(emitter); end
      def protected_activate; activate; end
    end
    
    class TestReceiver
      include Reru::Receiver
    end
    
    before(:each) do
      @emitter = TestEmitter.new
      @end_point = TestEndPoint.new
      @receiver = TestReceiver.new
    end
    
    it "adds emitters" do
      expect { @end_point.protected_add_emitter(@emitter) }.to_not raise_error
    end    
    
    it "raises on adding a non-emitter" do
      expect { @end_point.protected_add_emitter('non-emitter') }.to raise_error ArgumentError
    end
    
    it "raises on duplicate emitters" do
      expect { @end_point.protected_add_emitter(@emitter) }.to_not raise_error
      expect { @end_point.protected_add_emitter(@emitter) }.to raise_error ArgumentError
    end
    
    it "provides a :receive implementation" do
      @end_point.should respond_to(:receive)
    end
    
    it "subscribes to emitters on :activate" do
      @end_point.protected_methods.should include(:activate)
      @end_point.protected_add_emitter(@emitter)
      @emitter.should_receive(:add_receiver).once.with(@end_point)
      @end_point.protected_activate
    end
    
    it "dispatches events when :should_dispatch? return true" do
      @end_point.protected_add_emitter(@emitter)
      event = Reru::Next.new('here we go')
      @end_point.stub(:should_dispatch?).and_return(true)
      @end_point.should_receive(:dispatch).with(event)
      @end_point.receive(@emitter, event)
    end

    it "doesn't dispatch events when :should_dispatch? return false" do
      @end_point.protected_add_emitter(@emitter)
      event = Reru::Next.new('here we go')
      @end_point.stub(:should_dispatch?).and_return(false)
      @end_point.should_not_receive(:dispatch)
      @end_point.receive(@emitter, event)
    end
  end
end
