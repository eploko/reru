require 'active_support'

require 'reru/binary_runner'
require 'reru/property'
require 'reru/sink/operations'

class Reru::Scan < Reru::Property
  def initialize(sink, initial, method = nil, &block)
    super(sink, initial)
    @runner = Reru::BinaryRunner.new(method, &block)
  end
  
  module SinkOperations
    extend ActiveSupport::Concern

    included do
      def scan(*opts, &block)
        Reru::Scan.new(self, *opts, &block)
      end  
    end
  end
  Reru::Sink::Operations.send :include, SinkOperations
end
