require 'reru/more'
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
    Reru.more
  end  
end
