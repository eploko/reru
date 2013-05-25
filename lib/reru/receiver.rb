require 'observer'
require 'reru/event'
require 'reru/receiver/validations'
require 'reru/sink/validations'

module Reru::Receiver
  
  def receive(sink, event)
    raise ArgumentError, 'Unknown sink' unless has_sink?(sink)
    validate_event(event)
    shutdown(sink) if event.eos?
    dispatch(event) if should_dispatch?
  end
  
protected

  def add_sink(sink)
    validate_sink(sink)
    raise ArgumentError, "Duplicate sinks are not allowed." if has_sink?(sink)
    sinks << sink
  end
  
  def activate
    sinks.each do |e|
      e.add_receiver(self)
    end
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
    
end
