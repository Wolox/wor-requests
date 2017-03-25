require 'generator_spec'
require 'generators/wor/requests/install_generator'

describe Wor::Requests::Generators::InstallGenerator, type: :generator do
  context 'generating the initializer ' do
    destination File.expand_path('../../../../tmp', __FILE__)

    before(:all) do
      prepare_destination
      run_generator
    end

    it 'generates the correct structure for initializer' do
      expect(destination_root).to have_structure do
        no_file 'wor_requets.rb'
        directory 'config' do
          no_file 'wor_requets.rb'
          directory 'initializers' do
            file 'wor_requests.rb' do
              contains 'Wor::Requests.configure do'
            end
          end
        end
      end
    end
  end
end
