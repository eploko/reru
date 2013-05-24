require 'reru/source'

class Reru::Stream < Reru::Source
  def to_stream
    self
  end
    
  def merge(right)
    Reru::Stream.new(self, right)
  end
end
