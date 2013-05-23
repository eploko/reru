require 'reru/event'

class Reru::EOSEvent < Reru::Event
  def eos? ; true ; end
end
