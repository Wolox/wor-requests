require 'logger'

module Wor
  module Requests
    class ExternalApiService
      # TODO: add query to requests like httparty

      include HTTParty

      def initialize
        @logger = Logger.new
        self.class.base_uri base_url
      end

      protected

      def request_with_query_params(method:, endpoint:, attempting_to:, query: {}, headers: {})
        log_attempt attempting_to
        response = self.class.send(method, endpoint, options(headers: headers))
        if response.success?
          log_success attempting_to
          return (block_given? ? yield(response) : response)
        end
        log_error(response: response, attempting_to: attempting_to)
        raise RequestError.new(response), exception_message
      end

      def request_with_body(method:, endpoint:, body:, attempting_to:, headers: {})
        log_attempt attempting_to
        response = self.class.send(method, endpoint, options(body: body, headers: headers))
        if response.success?
          log_success attempting_to
          return (block_given? ? yield(response) : response)
        end
        log_error(response: response, attempting_to: attempting_to)
        raise RequestError.new(response), exception_message
      end

      def log_success(attempt)
        @logger.info "Successfully #{attempt}"
      end

      def log_attempt(attempt)
        @logger.info "Attempting to #{attempt}"
      end

      def log_error(response:, attempting_to:)
        response_error = "Error when trying to #{attempting_to}. Status code: #{response.code}. "
        response_error << "Response error: #{JSON.parse(response.body)}" if response.body.present?
        @logger.error response_error
      rescue => e
        @logger.error("#{response_error} Error while parsing response body: #{e.message}")
      end

      def exception_message
        external_api_name + 'communication error'
      end

      def options(headers:, body: {})
        { body: body, headers: headers }
      end

      # This can be Overriden in the child class for a more descriptive error message
      def external_api_name
        self.class.name
      end

      # Must be overriden
      def base_url
        raise 'SubclassResponsibility'
      end
    end
  end
end
