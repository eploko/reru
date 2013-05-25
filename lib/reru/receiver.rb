require 'observer'
require 'reru/event'
require 'reru/receiver/validations'
require 'reru/sink/validations'

module Reru::Receiver
  
  def receive(sink, event)
    raise ArgumentError, 'Unknown sink' unless has_sink?(sink)
    validate_event(event)
    unsubscribe(sink) if event.eos?
    dispatch(event)
  end
  
protected

  def add_sink(sink)
    validate_sink(sink)
    raise ArgumentError, "Duplicate sinks are not allowed." if has_sink?(sink)
    subscribe(sink)
  end
  
private

  include Reru::Sink::Validations
  include Reru::Event::Validations

  def sinks
    @sinks ||= []    
  end

  def has_sink?(sink)
    sinks.include?(sink)
  end
  
  def subscribe(sink)
    sinks << sink
    sink.add_receiver(self)
  end

  def unsubscribe(sink)
    sinks.delete(sink)
    sink.remove_receiver(self)
  end    
end
