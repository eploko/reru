require 'reru/sink'

class Reru::Emitter
  include Reru::Sink
  
  def initialize(target_run_loop = Reru.run_loop)
    self.run_loop = target_run_loop
    self.run_loop.add_emitter(self)
  end
  
  def tick
    Reru.enough
  end
end
