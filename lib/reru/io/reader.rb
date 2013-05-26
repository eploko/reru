require 'reru/emitter'

class Reru::IO::Reader < Reru::Emitter
  def initialize(io)
    super()
    @io = io
    @should_stop = false
  end
  
  def tick
    sink(Reru::EOS) and return Reru.enough if @should_stop
    process_next_line
  end
  
  def stop
    @should_stop = true
  end
  
private
    
  def process_next_line
    if line = @io.gets
      sink(Reru::Next.new(line))
      Reru.more
    else 
      sink(Reru::EOS)
      Reru.enough
    end
  end
  
  module ReruExt
    def read(io = $stdin)
      Reru::IO::Reader.new(io)
    end
  end
  Reru.send :extend, ReruExt
end
