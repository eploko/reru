class Reru::StreamConsumer
  def initialize(source, &block)
    @block = block
    source.add_observer(self)
  end
  
  def update(source, event)
    return if event.eos?
    @block.call(event.value)
  end
end
