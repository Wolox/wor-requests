module Wor
  module Requests
    class RequestError < StandardError
      attr_reader :response

      def initialize(response)
        @response = response
      end
    end
  end
end
