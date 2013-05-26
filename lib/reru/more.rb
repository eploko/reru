require 'singleton'

module Reru
  More = Struct.new(:is_more)
  
  def self.more
    More.new(true)
  end
  
  def self.enough
    More.new(false)
  end
end

