module Wor
  module Requests
    class InvalidOptionsError < StandardError
      attr_reader :errors

      def initialize(errors)
        @errors = errors
      end
    end
  end
end
