require 'reru/eos'
require 'reru/next'
require 'reru/stream'

class Reru::EnumerableEmitter < Reru::Stream
  def initialize(enumerable)
    raise ArgumentError, 'An Enumerable expected.' unless enumerable.is_a? Enumerable
    super()
    @enumerable = enumerable
  end  
  
  def run
    @enumerable.each { |value| sink(Reru::Next.new(value)) }
    sink(Reru::EOS)
  end
end
