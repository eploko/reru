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
  
  def dispatch(event)
    emit(event)    
  end

protected

  def receiver_added(receiver)
  end
      
  def run ; end
  
  def flush ; run ; end

end
