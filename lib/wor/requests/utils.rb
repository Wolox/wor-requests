require 'fileutils'

module Wor
  module Requests
    module Utils
      def root_path
        @root_path ||= (rails? ? Rails.root.to_s : Dir.pwd).to_s
      end

      def rails?
        @rails ||= defined?(::Rails) && ::Rails.respond_to?(:application)
      end

      def open_file(path, permissions = 'r')
        # TODO: test this
        FileUtils.mkdir_p File.dirname(path)
        File.open(path, permissions)
      end
    end
  end
end
