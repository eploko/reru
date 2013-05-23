require 'reru/event'

class Reru::Next < Reru::Event
  attr_reader :value
  
  def initialize(value)
    @value = value
  end

  def next? ; true ; end
  def value? ; true ; end
end
