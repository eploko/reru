require 'reru/event'

class Reru::EOSEvent < Reru::Event
  def eos? ; true ; end
  def to_s ; '<Reru::EOS>' ; end
end
