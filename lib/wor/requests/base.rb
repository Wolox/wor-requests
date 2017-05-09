require 'uri'
require 'httparty'
require 'json'

# rubocop:disable ClassLength
module Wor
  module Requests
    class Base
      VALID_HTTP_VERBS = %i(get post patch put delete).freeze

      # According to RFC 7231
      COMMON_ATTRIBUTES = %i(path headers attempting_to response_type).freeze
      HAS_QUERY         = [:query].freeze
      HAS_BODY          = [:body].freeze
      HTTP_COMPLETE     = (COMMON_ATTRIBUTES + HAS_QUERY + HAS_BODY).freeze
      HTTP_QUERY_ONLY   = (COMMON_ATTRIBUTES + HAS_QUERY).freeze
      GET_ATTRIBUTES    = HTTP_QUERY_ONLY
      POST_ATTRIBUTES   = HTTP_COMPLETE
      PATCH_ATTRIBUTES  = HTTP_COMPLETE
      PUT_ATTRIBUTES    = HTTP_COMPLETE
      DELETE_ATTRIBUTES = HTTP_QUERY_ONLY

      # Define the methods:
      #   - get(opts = {}, &block)
      #   - post(opts = {}, &block)
      #   - patch(opts = {}, &block)
      #   - put(opts = {}, &block)
      #   - delete(opts = {}, &block)
      VALID_HTTP_VERBS.each do |method|
        define_method(method) do |opts = {}, &block|
          method_attributes = constantize("#{method.upcase}_ATTRIBUTES")
          unpermitted_attributes = opts.keys - method_attributes
          unless unpermitted_attributes.empty?
            raise Wor::Requests::InvalidOptionsError.new(method_attributes, unpermitted_attributes)
          end

          request(opts.merge(method: method), &block)
        end
      end

      def request(options = {}, &block)
        validate_method!(options[:method])

        log_attempt(options[:attempting_to])
        resp = HTTParty.send(options[:method], uri(options[:path]), request_parameters(options))

        return after_success(resp, options, &block) if resp.success?
        after_error(resp, options)
      end

      def logger
        Wor::Requests.logger
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

      def after_success(response, options)
        log_success(options[:attempting_to])

        return yield(response) if block_given?
        handle_response(response, options[:response_type])
      end

      def after_error(response, options)
        log_error(response, options[:attempting_to])
        raise Wor::Requests::RequestError.new(response), exception_message
      end

      def uri(path)
        URI.join(formatted_base_url, formatted_path(path))
      end

      def formatted_base_url
        base_url[-1] != '/' ? "#{base_url}/" : base_url
      end

      def formatted_path(path)
        return '' if path.nil?
        return path if path[0] != '/'
        path.slice!(0)
        path
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
        response_error = "ERROR when trying to #{attempting_to}. "
        response_error << "Got status code: #{response.code}. "
        if present?(response.body)
          response_error << "Response error: #{JSON.parse(response.body)}"
        end
        logger.error response_error
      rescue => e
        logger.error("#{response_error} ERROR while parsing response body: #{e.message}.")
      end

      def exception_message
        "#{external_api_name} got an error. See logs for more information."
      end

      def request_parameters(options_hash)
        answer = {}
        answer[:body] = options_hash[:body] if present?(options_hash[:body])
        answer[:query] = options_hash[:query] if present?(options_hash[:query])
        answer[:headers] = options_hash[:headers] if present?(options_hash[:headers])
        answer
      end

      def present?(object)
        !object.nil?
      end

      def constantize(string)
        self.class.class_eval(string)
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
