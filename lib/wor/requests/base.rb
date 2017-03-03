require 'uri'
require 'httparty'
require 'json'

# rubocop:disable ClassLength
module Wor
  module Requests
    class Base
      VALID_HTTP_VERBS = [:get, :post, :patch, :put, :delete].freeze
      # According to RFC 7231
      VALID_COMMON_ATTRIBUTES = [:path, :headers, :attempting_to, :response_type].freeze
      VALID_GET_ATTRIBUTES    = VALID_COMMON_ATTRIBUTES + [:query]
      VALID_POST_ATTRIBUTES   = VALID_COMMON_ATTRIBUTES + [:body, :query]
      VALID_PATCH_ATTRIBUTES  = VALID_COMMON_ATTRIBUTES + [:body, :query]
      VALID_PUT_ATTRIBUTES    = VALID_COMMON_ATTRIBUTES + [:body, :query]
      VALID_DELETE_ATTRIBUTES = VALID_COMMON_ATTRIBUTES + [:query]

      def get(opts = {}, &block)
        request(
          opts.select { |k, _v| VALID_GET_ATTRIBUTES.include?(k) }.merge(method: :get),
          &block
        )
      end

      def post(opts = {}, &block)
        request(
          opts.select { |k, _v| VALID_POST_ATTRIBUTES.include?(k) }.merge(method: :post),
          &block
        )
      end

      def patch(opts = {}, &block)
        request(
          opts.select { |k, _v| VALID_PATCH_ATTRIBUTES.include?(k) }.merge(method: :patch),
          &block
        )
      end

      def put(opts = {}, &block)
        request(
          opts.select { |k, _v| VALID_PUT_ATTRIBUTES.include?(k) }.merge(method: :put),
          &block
        )
      end

      def delete(opts = {}, &block)
        request(
          opts.select { |k, _v| VALID_DELETE_ATTRIBUTES.include?(k) }.merge(method: :delete),
          &block
        )
      end

      # rubocop:disable AbcSize
      # rubocop:disable MethodLength
      def request(options = {})
        validate_method!(options[:method])

        log_attempt(options[:attempting_to])
        resp = HTTParty.send(options[:method], uri(options[:path]), request_parameters(options))

        if resp.success?
          log_success(options[:attempting_to])
          return yield(resp) if block_given?
          handle_response(resp, options[:response_type])
        else
          log_error(resp, options[:attempting_to])
          raise Wor::Requests::RequestError, exception_message
        end
      end

      protected

      def base_url
        raise NoMethodError, "Subclass must implement method: '#{__method__}'"
      end

      def external_api_name
        self.class.name
      end

      def default_response_type
        Wor::Requests.default_response_type
      end

      private

      def uri(path)
        URI.join(base_url, path)
      end

      def logger
        Wor::Requests.logger
      end

      def log_success(attempt)
        return unless present?(attempt)
        logger.info "SUCCESS: #{attempt}"
      end

      def log_attempt(attempt)
        return unless present?(attempt)
        logger.info "ATTEMPTING TO: #{attempt}"
      end

      def log_error(response, attempting_to)
        return unless present?(attempting_to)
        response_error = "ERROR when trying to #{attempting_to}. Status code: #{response.code}. "
        response_error << "Response error: #{JSON.parse(response.body)}" if present?(response.body)
        logger.error response_error
      rescue => e
        logger.error("#{response_error} ERROR while parsing response body: #{e.message}.")
      end

      def exception_message
        "#{external_api_name} communication error. See logs for more information."
      end

      def request_parameters(options_hash)
        answer = {}
        answer[:body] = options_hash[:body] if present?(options_hash[:body])
        answer[:query] = options_hash[:query] if present?(options_hash[:query])
        answer[:headers] = options_hash[:headers] if present?(options_hash[:headers])
        answer
      end

      # rubocop:disable DoubleNegation
      def present?(object)
        !!object
      end

      def validate_method!(method)
        return true if VALID_HTTP_VERBS.include?(method)
        raise ArgumentError, "#{method} is not a valid method."
      end

      def response_type(type)
        return type if Wor::Requests::VALID_RESPONSE_TYPES.include?(type)
        default_response_type
      end

      def handle_response(response, response_type)
        case response_type(response_type)
        when :json
          JSON.parse(response.body)
        else
          response.body
        end
      end
    end
  end
end
