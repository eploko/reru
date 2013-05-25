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
    
    before(:each) do
      @emitter = TestEmitter.new
      @end_point = TestEndPoint.new
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
  end
end
