require 'reru/stream'

class Reru::Map < Reru::Stream
  def initialize(source, &block)
    super(source)
    @block = block
  end
  
  def emit(event)
    return if event == Reru::EOS
    super @block.call(event.value)
  end
end
