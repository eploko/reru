require 'reru/stream'

class Reru::EnumerableStream < Reru::Stream
  def initialize(enumerable)
    @enumerable = enumerable
  end  
  
  def run
    @enumerable.each { |value| emit(value) }
  end
end
