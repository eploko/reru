require 'reru/source'

class Reru::Stream < Reru::Source
  def initialize(*sources)
    super
  end
  
  def to_es ; self ; end
    
  def merge(right)
    Reru::Stream.new(self, right)
  end
end
