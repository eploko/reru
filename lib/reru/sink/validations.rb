module Reru
  module Sink
    module Validations
      def validate_sink(sink)
        raise ArgumentError, "A Reru::Sink expected. Got: #{sink.class}" unless sink.is_a?(Reru::Sink)
      end
    end
  end
end
