require 'observer'

require 'reru/stream_consumer'

class Reru::Stream
  include Observable

  def initialize(*sources)
    @sources = []
    subscribe(*sources)
  end
  
  def to_es ; self ; end
  
  def update(source, value)
    emit(value)
    shutdown(source) if is_eos?(value)
  end
  
  def emit(value)
    changed
    notify_observers(self, value)
  end
  
  def consume(&block)
    Reru::StreamConsumer.new(self, &block)
  end
  
  def select(&block)
    Reru::Select.new(self, &block)
  end
  
  def merge(left, right)
    new(left, right)
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
    puts "Stream has ENDED: #{source}"
    unsubscribe(source)
  end
  
  def unsubscribe(source)
    source.delete_observer(self)
    @sources.delete(source)
  end
end