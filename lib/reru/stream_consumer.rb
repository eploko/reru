class Reru::StreamConsumer
  def initialize(source, &block)
    @block = block
    source.add_observer(self)
  end
  
  def update(source, value)
    return if value == Reru::EOS
    @block.call(value)
  end
end
