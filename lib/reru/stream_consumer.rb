class Reru::StreamConsumer
  def initialize(source, &block)
    @block = block
    source.add_observer(self)
  end
  
  def update(value)
    @block.call(value)
  end
end
