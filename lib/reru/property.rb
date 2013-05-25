require 'reru/next'
require 'reru/end_point'

class Reru::Property < Reru::EndPoint
  attr_reader :value
  
  def initialize(source, initial)
    super(source)
    @value = initial
  end

  def dispatch(event)
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
