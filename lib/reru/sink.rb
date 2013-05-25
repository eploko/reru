require 'reru/event/validations'
require 'reru/receiver/validations'
require 'reru/sink/operations'

module Reru::Sink
  include Reru::Sink::Operations
  
  def add_receiver(receiver)
    validate_receiver(receiver)
    receivers << receiver
  end

  def sink(event)
    validate_event(event)
    receivers.each do |r|
      r.receive(self, event)
    end
  end
  
private

  include Reru::Receiver::Validations
  include Reru::Event::Validations
    
  def receivers
    @receivers ||= []
  end
  
end
