require 'singleton'

require 'reru/event'

module Reru
  EOS = lambda {
    class EOSEvent < Reru::Event
      include Singleton
  
      def end? ; true ; end
      def to_s ; '<Reru::EOS>' ; end
    end
    EOSEvent::instance
  }.call.freeze
end

