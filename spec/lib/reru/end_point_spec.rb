require 'spec_helper'

describe Reru::EndPoint do
  before(:all) do
    class TestSink
      include Reru::Sink
    end
    class TestReceiver
      include Reru::Receiver
    end
  end
  
end