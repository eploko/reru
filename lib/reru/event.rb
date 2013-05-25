require 'reru/event/validations'

class Reru::Event
  def eos? ; false ; end
  def next? ; false ; end
  def value? ; false ; end
end
