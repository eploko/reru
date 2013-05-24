require 'active_support'

require 'reru/next'
require 'reru/stream'

class Reru::FlatMap < Reru::Stream
  def initialize(source, &block)
    super(source)
    @block = block
  end
  
  def emit(event)
    if event.value?
      super Reru::Next.new(@block.call(event.value)) if @block.call(event.value)
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
  Reru::Source.send :include, SourceMethods
end
