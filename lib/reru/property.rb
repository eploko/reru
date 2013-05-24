require 'reru/next'
require 'reru/source'

class Reru::Property < Reru::Source
  def initialize(source, initial)
    super(source)
    @result = initial
  end

  def emit(event)
    if event.value?
      @result = @valuator.run(@result, event.value)
      super Reru::Next.new(@result)
    else
      super
    end
  end
end
