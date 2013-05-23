require 'active_support'

require 'reru/enumerable_stream'

module Reru::CoreExt::Enumerable
  extend ActiveSupport::Concern

  included do
    def to_es
      Reru::EnumerableStream.new(self)
    end
  end
end

Enumerable.send :include, Reru::CoreExt::Enumerable
