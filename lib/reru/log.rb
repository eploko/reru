require 'active_support'

require 'reru/stream'

class Reru::Log < Reru::Stream
  def emit(event)
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
  Reru::Source.send :include, SourceMethods
end
