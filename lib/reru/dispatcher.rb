class Reru::Dispatcher
  def initialize(*sources)
    @sources = sources
  end
  
  def each(&sink)
    @sink = sink
    subscribe(*@sources)
  end
  
  def subscribe(*sources)
    sources.each do |source|
      @sources << source
      source.add_observer(self)
    end
  end
  
  def update(source, event)
    @sink.call(event)
    shutdown(source) if event.eos?
  end
  
  def shutdown(source)
    unsubscribe(source)
  end
  
  def unsubscribe(source)
    source.delete_observer(self)
    @sources.delete(source)
  end  
end
