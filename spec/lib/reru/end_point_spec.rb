require 'spec_helper'

describe Reru::EndPoint do
  before(:all) do
    class TestSink
      include Reru::Sink
    end
  end
  
  it "dispatches events" do
    sink = TestSink.new
    end_point = Reru::EndPoint.new(sink)
    event = Reru::Next.new(1)
    downstream = Reru::EndPoint.new(end_point)
    downstream.should_receive(:dispatch).with(event).once
    sink.sink(event)
  end
end