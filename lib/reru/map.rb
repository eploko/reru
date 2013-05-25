require 'active_support'

require 'reru/next'
require 'reru/sink/operations'
require 'reru/stream'
require 'reru/unary_runner'

class Reru::Map < Reru::Stream
  def initialize(source, method = nil, &block)
    super(source)
    @runner = Reru::UnaryRunner.new(method, &block)
  end
  
  def sink(event)
    if event.value?
      step = @runner.run(event.value)
      super Reru::Next.new(step) if step
    else
      super
    end
  end

  module SinkOperations
    extend ActiveSupport::Concern

    included do
      def map(*opts, &block)
        Reru::Map.new(self, *opts, &block)
      end
    end
  end
  Reru::Sink::Operations.send :include, SinkOperations
end
