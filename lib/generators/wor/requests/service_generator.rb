module Wor
  module Requests
    module Generators
      class ServiceGenerator < Rails::Generators::NamedBase
        SERVICE_DIR_PATH = 'app/services'.freeze
        source_root File.expand_path('../../../templates', __FILE__)
        desc 'Creates Wor-requests service for your application'

        class_option :module, type: :string

        def create_service
          @module_name = options[:module]

          generator_dir_path = "#{SERVICE_DIR_PATH}
            #{("/#{@module_name.underscore}" if @module_name.present?)}"
          generator_path = "#{generator_dir_path}/#{file_name}_service.rb"

          FileUtils.mkdir_p(generator_dir_path) unless File.exist?(generator_dir_path)

          template 'base_service.rb.erb', generator_path
        end
      end
    end
  end
end
