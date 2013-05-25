require 'observer'
require 'reru/event'
require 'reru/receiver/validations'

module Reru::Receiver
  
  def receive(emitter, event)
    raise ArgumentError, 'Unknown source' unless has_emitter? emitter
    raise ArgumentError, 'Only Reru::Events can be consumed.' unless event.is_a? Reru::Event
    shutdown(emitter) if event.eos?
    return unless sink?
    dispatch(event)
  end
  
protected

  def emitters
    @emitters ||= []    
  end

  def add_emitter(emitter)
    validate_emitter(emitter)
    self.emitters << emitter
  end

private

  def has_emitter?(emitter)
    self.emitters.include? emitter
  end

  def validate_emitter(emitter)
    raise ArgumentError, "A Reru::Emitter expected. Got: #{emitter.class}" unless emitter.is_a?(Reru::Emitter)
    raise ArgumentError, "Duplicate emitters are not allowed." if has_emitter?(emitter)
  end
  
  # def sink?
  #   !!@sink
  # end
      
  # def shutdown(source)
  #   unsubscribe(source)
  # end
  # 
  # def unsubscribe(source)
  #   source.delete_observer(self)
  #   @sources.delete(source)
  # end
end
