require 'reru/enumerable_emitter'

class Reru::Never < Reru::EnumerableEmitter
  def initialize
    super([])
  end

  def to_s ; '<Reru::Never>' ; end
end

module Reru
  def self.never
    Reru::Never.new
  end
end
