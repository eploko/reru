require 'active_support'

require 'reru/binary_runner'
require 'reru/end_point'
require 'reru/property'

class Reru::Scan < Reru::Property
  def initialize(source, initial, method = nil, &block)
    super(source, initial)
    @runner = Reru::BinaryRunner.new(method, &block)
  end
  
  module SourceMethods
    extend ActiveSupport::Concern

    included do
      def scan(*opts, &block)
        Reru::Scan.new(self, *opts, &block)
      end  
    end
  end
  Reru::EndPoint.send :include, SourceMethods
end
