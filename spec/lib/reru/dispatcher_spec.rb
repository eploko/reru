require 'spec_helper'

require 'observer'

describe Reru::Dispatcher do
  before(:each) do
    class NonObservableTarget 
    end
    @non_observable_target_a = NonObservableTarget.new
    @non_observable_target_b = NonObservableTarget.new

    class ObservableTarget 
      include Observable
    end
    @observable_target_a = ObservableTarget.new
    @observable_target_b = ObservableTarget.new
  end
  
  it "accepts only observable targets" do
    expect { Reru::Dispatcher.new(@non_observable_target_a) }.to raise_error ArgumentError
    expect { Reru::Dispatcher.new(@observable_target_a) }.to_not raise_error
    expect { Reru::Dispatcher.new(@non_observable_target_a, @non_observable_target_b) }.to raise_error ArgumentError
    expect { Reru::Dispatcher.new(@observable_target_a, @observable_target_b) }.to_not raise_error
  end
  
  it "raises ArgumentError on a duplicate source" do
    expect { Reru::Dispatcher.new(@observable_target_a, @observable_target_a) }.to raise_error ArgumentError
  end
  
  it "acts as an observer" do
    dispatcher = Reru::Dispatcher.new
    dispatcher.should respond_to :update
  end

  it "subscribes to sources only when someone would like to consume dispatched events" do
    @observable_target_a.should_not_receive(:add_observer)
    @observable_target_b.should_not_receive(:add_observer)
    dispatcher = Reru::Dispatcher.new(@observable_target_a, @observable_target_b)
  end
  
  it "subscribes to the all of the given sources" do
    @observable_target_a.should_receive(:add_observer)
    @observable_target_b.should_receive(:add_observer)
    dispatcher = Reru::Dispatcher.new(@observable_target_a, @observable_target_b).each do |x| 
      # nop
    end
  end

  context "on inbound events" do
    it "raises ArgumentError on an invalid source" do
      dispatcher = Reru::Dispatcher.new(@observable_target_a)      
      expect { dispatcher.update(nil, nil) }.to raise_error ArgumentError
      expect { dispatcher.update(@non_observable_target_a, nil) }.to raise_error ArgumentError
    end

    it "raises ArgumentError on non Reru::Event events" do
      dispatcher = Reru::Dispatcher.new(@observable_target_a)
      expect { dispatcher.update(@observable_target_a, 'invalid event') }.to raise_error ArgumentError
    end
    
    it "sinks inbound events to the consumer" do
      event = Reru::Event.new
      dispatcher = Reru::Dispatcher.new(@observable_target_a)
      dispatcher.each do |x| 
        x.should === event
        # nop
      end    
      dispatcher.update(@observable_target_a, event)
    end    
  end
end
