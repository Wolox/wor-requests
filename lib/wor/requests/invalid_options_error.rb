module Wor
  module Requests
    class InvalidOptionsError < StandardError
      attr_reader :valid
      attr_reader :invalid

      def initialize(valid, invalid)
        @valid = valid
        @invalid = invalid
      end
    end
  end
end
