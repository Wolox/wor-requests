module Wor
  module Requests
    class MalformedBaseUrl < StandardError
      def initialize(msg = 'The method base_url is malformed')
        super(msg)
      end
    end
  end
end
