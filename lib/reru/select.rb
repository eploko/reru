require 'reru/stream'

class Reru::Select < Reru::Stream
  def initialize(source, &block)
    super(source)
    @block = block
  end
  
  def update(value)
    super if @block.call(value)
  end
end
