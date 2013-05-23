require 'reru/stream'

class Reru::Select < Reru::Stream
  def initialize(source, &block)
    super(source)
    @block = block
  end
  
  def emit(value)
    return if value == Reru::EOS
    super if @block.call(value)
  end
end
