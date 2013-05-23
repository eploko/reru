require 'observer'

# before we require all of the subclasses, we need to have Stream defined
class Reru::Stream
end

require 'reru/consume'
require 'reru/dispatcher'
require 'reru/log'
require 'reru/map'
require 'reru/select'

class Reru::Stream
  include Observable

  def initialize(*sources)
    Reru::Dispatcher.new(*sources).each { |event| dispatch(event) }
  end
  
  def to_es ; self ; end
  
  def dispatch(event)
    emit(event)    
  end
    
  def emit(event)
    changed
    notify_observers(self, event)
  end
  
  def merge(right)
    Reru::Stream.new(self, right)
  end
  
  def consume(&block)
    Reru::Consume.new(self, &block)
  end
  
  def select(&block)
    Reru::Select.new(self, &block)
  end
  
  def map(&block)
    Reru::Map.new(self, &block)
  end
  
  def log
    Reru::Log.new(self)
  end
end
