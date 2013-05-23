require 'reru/stream'

class Reru::Map < Reru::Stream
  def initialize(source, &block)
    super(source)
    @block = block
  end
  
  def emit(value)
    return if value == Reru::EOS
    super @block.call(value)
  end
end
