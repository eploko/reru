require 'active_support'

require 'reru/sink/operations'
require 'reru/stream'

class Reru::Perform < Reru::Stream
  def initialize(sink, method = nil, &block)
    super(sink)
    @runner = Reru::UnaryRunner.new(method, &block)
  end

  def dispatch(event)
    if event.value?
      @runner.run(event.value)
    end
    super
  end
  
  module SinkOperations
    extend ActiveSupport::Concern

    included do
      def perform(&block)
        Reru::Perform.new(self, &block)
      end
      
      def log(prefix = '')
        prefix = prefix + ' ' unless prefix.empty?
        Reru::Perform.new(self) { |x| puts "#{prefix}#{x.inspect}" }
      end

      def write(io = $stdout)
        Reru::Perform.new(self) { |x| io.write(x) }
      end
    end
  end
  Reru::Sink::Operations.send :include, SinkOperations
end
