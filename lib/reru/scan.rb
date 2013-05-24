require 'active_support'

require 'reru/func_runner'
require 'reru/property'

class Reru::Scan < Reru::Property
  def initialize(source, initial, method = nil, &block)
    super(source, initial)
    @valuator = Reru::FuncRunner.new(method, &block)
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
