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
      validate_answer(r, a)
      a
    end
  end
  
private

  include Reru::Receiver::Validations
  include Reru::Event::Validations
    
  def receivers
    @receivers ||= []
  end
  
  def validate_answer(receiver, a)
    unless a.is_a?(Reru::More)
      raise TypeError, "#{receiver.class} returned and invalid answer of class: #{a.class}. A Reru::More expected."
    end
  end
  
end
