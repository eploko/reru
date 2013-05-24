require 'observer'
require 'reru/event'

class Reru::Dispatcher
  def initialize(*sources)
    validate_sources(sources)
    @sources = sources
  end

  def each(&sink)
    @sink = sink
    subscribe(*@sources)
  end

  def update(source, event)
    raise_on_non_observables [source]
    raise_on_non_event event
    @sink.call(event)
    shutdown(source) if event.eos?
  end

private  

  def validate_sources(sources)
    raise_on_non_observables sources
    raise_on_duplicates sources
  end
  
  def raise_on_non_observables(sources)
    sources.each do |s|
      unless s.class.include? Observable
        raise ArgumentError, 'All of the sources should be Observables.'
      end
    end    
  end
  
  def raise_on_duplicates(sources)
    unless sources.uniq.size == sources.size
      raise ArgumentError, 'Duplicate sources are not allowed.'
    end
  end
  
  def raise_on_non_event(event)
    raise ArgumentError, 'Only Reru::Events can be consumed.' unless event.is_a? Reru::Event
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
