require 'reru/sink'

class Reru::Emitter
  include Reru::Sink
  
  def start
    self
  end
end
