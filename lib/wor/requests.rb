require_relative 'requests/base'
require_relative 'requests/request_error'
require_relative 'requests/malformed_base_url'
require_relative 'requests/version'
require 'logger'

module Wor
  module Requests
    VALID_RESPONSE_TYPES = [:json].freeze

    @config = {
      logger: Logger.new(STDOUT),
      default_response_type: :json
    }

    def self.configure
      yield self
    end

    def self.logger=(logger)
      @config[:logger] = logger
    end

    def self.default_response_type=(type)
      return unless VALID_RESPONSE_TYPES.include?(type)

      @config[:default_response_type] = type
    end

    def self.config
      @config
    end

    def self.logger
      @config[:logger]
    end

    def self.default_response_type
      @config[:default_response_type]
    end
  end
end
