require 'reru/sink'
require 'reru/receiver'

class Reru::EndPoint
  include Reru::Receiver
  include Reru::Sink
  
  def initialize(*sinks)
    sinks.each do |s|
      add_sink(s)
    end
  end
  
protected

  def dispatch(event)
    sink(event)    
  end

  def receiver_added(receiver)
  end
  
  def should_dispatch?
    receivers?
  end
      
  def run ; end
  
  def flush ; run ; end

end
