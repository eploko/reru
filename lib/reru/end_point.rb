require 'reru/emitter'
require 'reru/receiver'

class Reru::EndPoint
  include Reru::Receiver
  include Reru::Emitter
  
  def initialize(*emitters)
    emitters.each do |s|
      add_emitter(s)
    end
  end
  
protected

  def dispatch(event)
    emit(event)    
  end

  def receiver_added(receiver)
  end
  
  def should_dispatch?
    receivers?
  end
      
  def run ; end
  
  def flush ; run ; end

end
