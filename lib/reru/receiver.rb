require 'observer'
require 'reru/emitter/validations'
require 'reru/event'
require 'reru/receiver/validations'

module Reru::Receiver
  
  def receive(emitter, event)
    raise ArgumentError, 'Unknown emitter' unless has_emitter?(emitter)
    validate_event(event)
    shutdown(emitter) if event.eos?
    return unless sink?
    dispatch(event)
  end
  
protected

  def add_emitter(emitter)
    validate_emitter(emitter)
    raise ArgumentError, "Duplicate emitters are not allowed." if has_emitter?(emitter)
    emitters << emitter
  end
  
  def activate
    emitters.each do |e|
      e.add_receiver(self)
    end
  end

private

  include Reru::Emitter::Validations
  include Reru::Event::Validations

  def emitters
    @emitters ||= []    
  end

  def has_emitter?(emitter)
    emitters.include?(emitter)
  end
    
end
