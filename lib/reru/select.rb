require 'active_support'

require 'reru/sink/operations'
require 'reru/stream'

class Reru::Select < Reru::Stream
  def initialize(sink, method = nil, &block)
    super(sink)
    @runner = Reru::UnaryRunner.new(method, &block)
  end
  
  def dispatch(event)
    if event.value?
      super if @runner.run(event.value)
    else
      super
    end
    Reru.more
  end
end

module Reru::Select::SinkOperations
  extend ActiveSupport::Concern

  included do
    def select(method = nil, &block)
      Reru::Select.new(self, method, &block)
    end
          
    def compact
      Reru::Select.new(self) { |x| not x.nil? }
    end
  end
end
Reru::Sink::Operations.send :include, Reru::Select::SinkOperations
