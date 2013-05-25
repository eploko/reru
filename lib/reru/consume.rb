require 'active_support'

require 'reru/end_point'

class Reru::Consume
  def initialize(source, &block)
    @block = block
    source.add_observer(self)
  end
  
  def update(source, event)
    return if event.eos?
    @block.call(event.value)
  end
  
  module SourceMethods
    extend ActiveSupport::Concern

    included do
      def consume(&block)
        Reru::Consume.new(self, &block)
      end
    end
  end
  Reru::EndPoint.send :include, SourceMethods
end
