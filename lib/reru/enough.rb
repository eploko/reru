require 'singleton'

module Reru
  class Enough
    include Singleton

    def ==(other)
      other.class == self.class
    end
  end
  ENOUGH = Enough::instance.freeze
end

