require 'reru/next'
require 'reru/stream'

class Reru::Map < Reru::Stream
  def initialize(source, &block)
    super(source)
    @block = block
  end
  
  def emit(event)
    if event.value?
      super Reru::Next.new(@block.call(event.value)) if @block.call(event.value)
    else
      super
    end
  end
end
