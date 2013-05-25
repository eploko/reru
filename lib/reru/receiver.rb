require 'observer'
require 'reru/event'
require 'reru/receiver/validations'

module Reru::Receiver

  def update(source, event)
    raise ArgumentError, 'Unknown source' unless has_source? source
    raise ArgumentError, 'Only Reru::Events can be consumed.' unless event.is_a? Reru::Event
    shutdown(source) if event.eos?
    return unless sink?
    dispatch(event)
  end
  
protected

  def sources
    @sources ||= []    
  end

  def add_source(source)
    validate_source(source)
    self.sources << source
  end

private

  def has_source?(source)
    self.sources.include? source
  end

  def validate_source(source)
    raise ArgumentError, 'All of the sources should be Observables.' unless source.is_a? Observable
    raise ArgumentError, 'Duplicate sources are not allowed.' if has_source? source
  end
  
  def sink?
    !!@sink
  end
  
  def subscribe(*sources)
    sources.each do |source|
      @sources << source
      source.add_observer(self)
    end
  end
    
  def shutdown(source)
    unsubscribe(source)
  end
  
  def unsubscribe(source)
    source.delete_observer(self)
    @sources.delete(source)
  end
end
