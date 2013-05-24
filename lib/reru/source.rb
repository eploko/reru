require 'observer'

require 'reru/dispatcher'

class Reru::Source
  include Observable

  def initialize(*sources)
    Reru::Dispatcher.new(*sources).each { |event| dispatch(event) }
  end

  def dispatch(event)
    emit(event)    
  end
    
  def emit(event)
    changed
    notify_observers(self, event)
  end
  
  def run ; end
  
  def flush ; run ; end
end
