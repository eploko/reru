module Reru
  class Event
    module Validations
      def validate_event(event)
        raise ArgumentError, "A Reru::Event is expected. Got: #{event.class}" unless event.is_a?(Reru::Event)
      end
    end
  end
end
