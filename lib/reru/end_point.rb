require 'reru/emitter'
require 'reru/receiver'

class Reru::EndPoint
  include Reru::Receiver
  include Reru::Emitter
  
  def initialize(*upstreams)
    upstreams.each do |s|
      add_upstream(s)
    end
  end
  
  def dispatch(event)
    emit(event)    
  end

protected
      
  def run ; end
  
  def flush ; run ; end

end
