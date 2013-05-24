require 'active_support'

require 'reru/stream'

class Reru::Select < Reru::Stream
  def initialize(source, &block)
    super(source)
    @block = block
  end
  
  def emit(event)
    if event.value?
      super if @block.call(event.value)
    else
      super
    end
  end

  module SourceMethods
    extend ActiveSupport::Concern

    included do
      def select(&block)
        Reru::Select.new(self, &block)
      end
    end
  end
  Reru::Source.send :include, SourceMethods
end
