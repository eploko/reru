require 'reru/enumerable_stream'

class Reru::Never < Reru::EnumerableStream
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
