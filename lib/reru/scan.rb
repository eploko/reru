require 'active_support'

require 'reru/func_runner'
require 'reru/next'
require 'reru/stream'

class Reru::Scan < Reru::Stream
  def initialize(source, initial, method = nil, &block)
    super(source)
    @result = initial
    @valuator = Reru::FuncRunner.new(method, &block)
  end
  
  def emit(event)
    if event.value?
      @result = @valuator.run(@result, event.value)
      super Reru::Next.new(@result)
    else
      super
    end
  end

  module SourceMethods
    extend ActiveSupport::Concern

    included do
      def scan(*opts)
        Reru::Scan.new(self, *opts)
      end  
    end
  end
  Reru::Source.send :include, SourceMethods
end
