require 'reru/stream'

class Reru::Select < Reru::Stream
  def initialize(source, &block)
    super(source)
    @block = block
  end
  
  def emit(event)
    if event.value?
      super if @block.call(event.value)
    else
      super
    end
  end
end
