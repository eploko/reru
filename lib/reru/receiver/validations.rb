module Reru
  module Receiver
    module Validations
      def validate_receiver(receiver)
         raise ArgumentError, "A Reru::Receiver is expected. Got: #{receiver.class}" unless receiver.is_a?(Reru::Receiver)
         raise ArgumentError, "The receiver of class #{receiver.class} should respond to :receive." unless receiver.respond_to?(:receive)
      end
    end
  end
end
