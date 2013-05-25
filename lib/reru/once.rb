require 'reru/enumerable_emitter'

class Reru::Once < Reru::EnumerableEmitter
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
