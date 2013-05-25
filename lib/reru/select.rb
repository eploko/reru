require 'active_support'

require 'reru/sink/operations'
require 'reru/stream'

class Reru::Select < Reru::Stream
  def initialize(source, &block)
    super(source)
    @block = block
  end
  
  def dispatch(event)
    if event.value?
      super if @block.call(event.value)
    else
      super
    end
  end

  module SinkOperations
    extend ActiveSupport::Concern

    included do
      def select(&block)
        Reru::Select.new(self, &block)
      end
    end
  end
  Reru::Sink::Operations.send :include, SinkOperations
end
