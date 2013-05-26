require 'active_support'

require 'reru/next'
require 'reru/sink/operations'
require 'reru/stream'

class Reru::FlatMap < Reru::Stream
  def initialize(sink, &block)
    super(sink)
    @block = block
    @pending_emitters = []
  end
  
  def dispatch(event)
    if event.value?
      mapped = @block.call(event.value)
      if mapped.is_a? Reru::Emitter
        @pending_emitters << mapped
        mapped.perform do |x| 
          super Reru::Next.new(x)
        end.on_eos do 
          @pending_emitters.delete(mapped)
          dispatch(Reru::EOS) if @pending_emitters.size == 0
        end
      else
        super Reru::Next.new(mapped)
      end
    else
      raise "Unsupported event: #{event}" unless event.eos?
      super if @pending_emitters.size == 0
    end
    Reru.more
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
