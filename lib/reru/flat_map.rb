require 'active_support'

require 'reru/end_point'
require 'reru/next'
require 'reru/stream'

class Reru::FlatMap < Reru::Stream
  def initialize(source, &block)
    super(source)
    @block = block
  end
  
  def emit(event)
    if event.value?
      mapped = @block.call(event.value)
      if mapped.is_a? Reru::Source
        mapped.consume{ |x| 
          super Reru::Next.new(x)
        }
        mapped.flush
      else
        super Reru::Next.new(mapped)
      end
    else
      super
    end
  end

  module SourceMethods
    extend ActiveSupport::Concern

    included do
      def flat_map(&block)
        Reru::FlatMap.new(self, &block)
      end
    end
  end
  Reru::EndPoint.send :include, SourceMethods
end
