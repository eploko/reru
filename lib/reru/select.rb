require 'reru/stream'

class Reru::Select < Reru::Stream
  def initialize(source, &block)
    super(source)
    @block = block
  end
  
  def emit(event)
    return if event == Reru::EOS
    super if @block.call(event.value)
  end
end
