module Reru
  module Emitter
    module Validations
      def validate_emitter(emitter)
        raise ArgumentError, "A Reru::Emitter expected. Got: #{emitter.class}" unless emitter.is_a?(Reru::Emitter)
      end
    end
  end
end
