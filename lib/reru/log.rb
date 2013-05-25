require 'active_support'

require 'reru/sink/operations'
require 'reru/stream'

class Reru::Log < Reru::Stream
  def dispatch(event)
    puts event
    super event
  end

  module SinkOperations
    extend ActiveSupport::Concern

    included do
      def log
        Reru::Log.new(self)
      end
    end
  end
  Reru::Sink::Operations.send :include, SinkOperations
end
