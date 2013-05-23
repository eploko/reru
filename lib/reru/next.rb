require 'reru/event'

class Reru::Next < Reru::Event
  attr_reader :value
  
  def initialize(value)
    @value = value
  end
end
