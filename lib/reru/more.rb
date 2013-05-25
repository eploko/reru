require 'singleton'

module Reru
  class More
    include Singleton

    def ==(other)
      other.class == self.class
    end
  end
  MORE = More::instance.freeze
end

