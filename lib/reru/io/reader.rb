require 'reru/emitter'

class Reru::IO::Reader < Reru::Emitter
  def initialize(io)
    super()
    @io = io
    @should_stop = false
  end
  
  def tick
    if @should_stop
      sink(Reru::EOS)
      Reru.enough 
    else
      process_next_chunk
    end
  end
  
  def stop
    @should_stop = true
  end
  
private
    
  def process_next_chunk
    @io.read_nonblock(1_000_000).each_line do |line|
      sink(Reru::Next.new(line))
    end
    Reru.more
  rescue IO::WaitReadable
    Reru.more
  rescue
    sink(Reru::EOS)
    Reru.enough
  end
  
  module ReruExt
    def read(io = $stdin)
      Reru::IO::Reader.new(io)
    end
  end
  Reru.send :extend, ReruExt
end
