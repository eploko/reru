require 'reru/event'

module Reru
  EOS = lambda {
    class Tmp < Reru::Event
      include Singleton
  
      def end? ; true ; end
      def to_s ; '<Reru::EOS>' ; end
    end
    Tmp::instance
  }.call.freeze
end

