require 'spec_helper'

describe Reru::EndPoint do
  before(:all) do
    class TestSink
      include Reru::Sink
    end
  end
  before(:each) do
    @sink = TestSink.new
    @end_point = Reru::EndPoint.new(@sink)
    # @downstream = double('downstream')
    # @downstream.stub(:update)
    # @end_point.add_downstream(@downstream)
    # @event = Reru::Next.new('here we go')    
    # @terminator = Reru::Consume.new(@downstream) { |v| 
    #   # nop 
    # }
  end

  it "responds to :receiver_added" do
    @end_point.protected_methods.should include(:receiver_added)
  end
  
  # context "on inbound events" do
  #   it "sinks them down the stream", do
  #     @end_point.update(@upstream, @event)
  #     @end_point.should_receive(:dispatch).with(@event)
  #   end    
  # end
  # 
  # it "propagates next events down" do
  #   @observer.should_receive(:update).with(@source, @event)
  #   @source.dispatch(@event)
  # end
  # 
  # it "propagates eos events down" do
  #   @observer.should_receive(:update).with(@source, Reru::EOS)
  #   @source.dispatch(Reru::EOS)    
  # end
  # 
  # it "unsubscribes from the upstream on an EOS event" do
  #   @upstream.should_receive(:delete_observer)
  #   @upstream.dispatch(Reru::EOS)
  # end
  # 
  # it "mixes in Observable" do
  #   @source.class.include?(Observable).should be_true
  # end
  # 
  # it "mixes in Reru::Dispatcher" do
  #   @source.class.include?(Reru::Dispatcher).should be_true
  # end
  # 
  # it "responds to :dispatch" do
  #   @source.respond_to?(:dispatch).should be_true
  # end
end