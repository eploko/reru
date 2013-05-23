require 'observer'

# before we require all of the subclasses, we need to have Stream defined
class Reru::Stream
end

require 'reru/dispatcher'
require 'reru/map'
require 'reru/select'
require 'reru/stream_consumer'

class Reru::Stream
  include Observable

  def initialize(*sources)
    Reru::Dispatcher.new(*sources).sink do |event|
      emit(event)
    end
  end
  
  def to_es ; self ; end
    
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
end
