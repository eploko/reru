require 'reru/event/validations'
require 'reru/more'
require 'reru/receiver/validations'
require 'reru/sink/operations'

module Reru::Sink
  include Reru::Sink::Operations
  
  def add_receiver(receiver)
    validate_receiver(receiver)
    receivers << receiver
  end
  
  def remove_receiver(receiver)
    validate_receiver(receiver)
    receivers.delete(receiver)
  end

  def sink(event)
    validate_event(event)
    receivers.each do |r|
      a = r.receive(self, event)
      validate_answer(a)
    end
  end
  
private

  include Reru::Receiver::Validations
  include Reru::Event::Validations
    
  def receivers
    @receivers ||= []
  end
  
  def validate_answer(a)
    unless a.is_a?(Reru::More)
      raise TypeError, "Invalid answer class from a receiver: #{a.class}. Should be either Reru.more or Reru.enough."
    end
  end
  
end
