require 'reru/eos'
require 'reru/next'
require 'reru/stream'

class Reru::EnumerableStream < Reru::Stream
  def initialize(enumerable)
    raise ArgumentError, 'An Enumerable expected.' unless enumerable.is_a? Enumerable
    super()
    @enumerable = enumerable
  end  
  
  def run
    @enumerable.each { |value| emit(Reru::Next.new(value)) }
    emit(Reru::EOS)
  end
end
