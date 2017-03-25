module Wor
  module Requests
    module Generators
      class InstallGenerator < Rails::Generators::Base
        source_root File.expand_path('../../../templates', __FILE__)
        desc 'Creates Wor-requests initializer for your application'

        def copy_initializer
          template 'wor_requests.rb', 'config/initializers/wor_requests.rb'
        end
      end
    end
  end
end
