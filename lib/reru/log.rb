require 'active_support'

require 'reru/end_point'
require 'reru/stream'

class Reru::Log < Reru::Stream
  def sink(event)
    puts event
    super event
  end

  module SourceMethods
    extend ActiveSupport::Concern

    included do
      def log
        Reru::Log.new(self)
      end
    end
  end
  Reru::EndPoint.send :include, SourceMethods
end
