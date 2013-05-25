require 'reru/event/validations'
require 'reru/receiver/validations'

module Reru::Emitter
  def add_receiver(receiver)
    validate_receiver(receiver)
    receivers << receiver
    receiver_added(receiver)
  end

  def emit(event)
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
