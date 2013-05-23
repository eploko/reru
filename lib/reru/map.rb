require 'reru/next'
require 'reru/stream'

class Reru::Map < Reru::Stream
  def initialize(source, &block)
    super(source)
    @block = block
  end
  
  def emit(event)
    return if event.eos?
    super Reru::Next.new(@block.call(event.value))
  end
end
