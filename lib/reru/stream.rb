require 'observer'

require 'reru/stream_consumer'

class Reru::Stream
  include Observable
  
  def initialize(*sources)
    sources.each do |source|
      source.add_observer(self)
    end
  end
  
  def to_es ; self ; end
  
  def update(value)
    emit(value)
  end
  
  def emit(value)
    changed
    notify_observers(value)
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
end
