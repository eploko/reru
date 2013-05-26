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
  
  def dispatch(event, passthru = false)
    unless passthru
      process(event)
    else
      super(event)
    end
  end

private

  def process(event)
    if event.value?
      map_value(event.value)
    else
      raise "Unsupported event: #{event}" unless event.eos?
      if @pending_emitters.size == 0
        dispatch(event, true)
      else
        Reru.more
      end
    end
  end
  
  def map_value(value)
    mapped = @block.call(value)
    if mapped.is_a? Reru::Emitter
      flat(mapped)
      Reru.more
    else
      dispatch(Reru::Next.new(mapped), true)
    end
  end
  
  def flat(mapped)
    @pending_emitters << mapped
    mapped.perform do |x| 
      dispatch(Reru::Next.new(x), true)
    end.on_eos do 
      @pending_emitters.delete(mapped)
      dispatch(Reru::EOS) if @pending_emitters.size == 0
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
