require 'singleton'

require 'reru/event'

module Reru
  class EOSEvent < Reru::Event
    include Singleton

    def eos? ; true ; end
    def to_s ; '<Reru::EOS>' ; end
    
    def ==(other)
      other.eos?
    end
  end
  EOS = EOSEvent::instance.freeze
end

