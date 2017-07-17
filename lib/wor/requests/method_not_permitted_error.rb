module Wor
  module Requests
    class MethodNotPermittedError < StandardError
      attr_reader :response

      def initialize(method)
        @method = method
      end
    end
  end
end
