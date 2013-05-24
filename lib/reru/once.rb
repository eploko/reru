require 'reru/enumerable_stream'

class Reru::Once < Reru::EnumerableStream
  def initialize(x)
    super([x])
  end

  def to_s ; '<Reru::Once{ x: #{x} }>' ; end
end

module Reru
  def self.once(x)
    Reru::Once.new(x)
  end
end
