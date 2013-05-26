require 'reru/stream'

class Reru::Bus < Reru::Stream
  def consume!(stream)
    stream.add_receiver(self)
  end
end

