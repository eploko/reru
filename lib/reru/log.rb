require 'reru/stream'

class Reru::Log < Reru::Stream
  def emit(event)
    puts event
    super event
  end
end
