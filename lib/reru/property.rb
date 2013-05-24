require 'reru/next'
require 'reru/source'

class Reru::Property < Reru::Source
  attr_reader :value
  
  def initialize(source, initial)
    super(source)
    @value = initial
  end

  def emit(event)
    if event.value?
      super Reru::Next.new(step(event.value))
    else
      super
    end
  end
  
  def step(x)
    @value = @runner.run(@value, x)
  end
end
