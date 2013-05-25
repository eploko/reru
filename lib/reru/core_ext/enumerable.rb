require 'active_support'

require 'reru/enumerable_emitter'

module Reru::CoreExt::Enumerable
  extend ActiveSupport::Concern

  included do
    def as_stream
      Reru::EnumerableEmitter.new(self)
    end
  end
end

Enumerable.send :include, Reru::CoreExt::Enumerable
