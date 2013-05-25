require 'reru/end_point'

class Reru::Stream < Reru::EndPoint
  def to_stream
    self
  end
    
  def merge(right)
    Reru::Stream.new(self, right)
  end
end
