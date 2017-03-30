module Wor
  module Requests
    module Generators
      class ServiceGenerator < Rails::Generators::NamedBase
        source_root File.expand_path('../../../templates', __FILE__)
        desc 'Creates Wor-requests service for your application'

        def create_service
          template 'base_service.rb.erb', "app/services/#{plural_name}_service.rb"
        end
      end
    end
  end
end
