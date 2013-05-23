require 'observer'

require 'reru/stream_consumer'

class Reru::Stream
  include Observable

  def initialize(*sources)
    @sources = []
    subscribe(*sources)
  end
  
  def to_es ; self ; end
  
  def update(source, event)
    emit(event)
    shutdown(source) if is_eos?(event)
  end
  
  def emit(event)
    changed
    notify_observers(self, event)
  end
  
  def consume(&block)
    Reru::StreamConsumer.new(self, &block)
  end
  
  def select(&block)
    Reru::Select.new(self, &block)
  end
  
  def merge(right)
    Reru::Stream.new(self, right)
  end

  def map(&block)
    Reru::Map.new(self, &block)
  end
  
  def is_eos?(value)
    value == Reru::EOS
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
