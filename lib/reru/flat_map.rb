require 'active_support'

require 'reru/next'
require 'reru/sink/operations'
require 'reru/stream'

class Reru::FlatMap < Reru::Stream
  def initialize(sink, &block)
    super(sink)
    @block = block
  end
  
  def dispatch(event)
    if event.value?
      mapped = @block.call(event.value)
      if mapped.is_a? Reru::Sink
        mapped.perform do |x| 
          super Reru::Next.new(x)
        end
        mapped.start
      else
        super Reru::Next.new(mapped)
      end
    else
      super
    end
  end

  module SinkOperations
    extend ActiveSupport::Concern

    included do
      def flat_map(&block)
        Reru::FlatMap.new(self, &block)
      end
    end
  end
  Reru::Sink::Operations.send :include, SinkOperations
end
