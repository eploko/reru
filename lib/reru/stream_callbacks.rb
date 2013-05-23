require 'active_support'

module Reru::StreamCallbacks
  include ActiveSupport::Callbacks
  define_callbacks :emit
end
