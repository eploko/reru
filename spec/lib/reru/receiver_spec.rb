require 'spec_helper'

describe Reru::Receiver do
  context "when included" do
    class TestEmitter
      include Reru::Emitter
    end
    
    class TestEndPoint
      include Reru::Receiver
      def protected_add_emitter(emitter); add_emitter(emitter); end
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
  end
  
  # class NonObservableTarget 
  # end
  # 
  # class ObservableTarget 
  #   include Observable
  # end
  # 
  # class TestSource
  #   include Reru::Dispatcher
  # end
  # 
  # before(:each) do
  #   @non_observable_target_a = NonObservableTarget.new
  #   @non_observable_target_b = NonObservableTarget.new
  # 
  #   @observable_target_a = ObservableTarget.new
  #   @observable_target_b = ObservableTarget.new
  #   
  # end
  # 
  # it "subscribes to sources only when someone would like to consume dispatched events" do
  #   @observable_target_a.should_not_receive(:add_observer)
  #   @observable_target_b.should_not_receive(:add_observer)
  #   dispatcher = TestSource.new(@observable_target_a, @observable_target_b)
  # end
  # 
  # it "subscribes to the all of the given sources" do
  #   @observable_target_a.should_receive(:add_observer)
  #   @observable_target_b.should_receive(:add_observer)
  #   dispatcher = TestSource.new(@observable_target_a, @observable_target_b).each do |x| 
  #     # nop
  #   end
  # end
  # 
  # context "on inbound events" do
  #   it "raises ArgumentError on an invalid source" do
  #     dispatcher = Reru::Dispatcher.new(@observable_target_a)      
  #     expect { dispatcher.update(nil, nil) }.to raise_error ArgumentError
  #     expect { dispatcher.update(@non_observable_target_a, nil) }.to raise_error ArgumentError
  #   end
  # 
  #   it "raises ArgumentError on non Reru::Event events" do
  #     dispatcher = Reru::Dispatcher.new(@observable_target_a)
  #     expect { dispatcher.update(@observable_target_a, 'invalid event') }.to raise_error ArgumentError
  #   end
  #   
  #   it "ignores events if there's no consumer" do
  #     dispatcher = Reru::Dispatcher.new(@observable_target_a)
  #     expect { dispatcher.update(@observable_target_a, Reru::Event.new) }.to_not raise_error
  #   end
  #   
  #   it "unsubscribes from the source if the event is an EOS" do
  #     dispatcher = Reru::Dispatcher.new(@observable_target_a)
  #     @observable_target_a.should_receive(:delete_observer).with(dispatcher)
  #     dispatcher.update(@observable_target_a, Reru::EOS)
  #   end
  # end
end
