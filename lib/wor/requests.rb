require 'wor/requests/version'
require 'logger'

module Wor
  module Requests
    @config = {
      logger: Logger.new(STDOUT)
    }

    def self.configure
      yield self
    end

    def self.logger=(logger)
      @config[:logger] = logger
    end

    def self.config
      @config
    end
  end
end
