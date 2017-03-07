require 'generator_spec'
require 'generators/wor/requests/service_generator'

describe Wor::Requests::Generators::ServiceGenerator, type: :generator do
  context 'generating a service with a name' do
    destination File.expand_path('../../../../tmp', __FILE__)
    arguments %w[book]

    before(:all) do
      prepare_destination
      run_generator
    end

    it 'generates the correct structure for the service' do
      expect(destination_root).to have_structure do
        no_file 'books_service.rb'
        directory 'app' do
          no_file 'books_service.rb'
          directory 'services' do
            file 'books_services.rb' do
              contains 'class BooksService < Wor::Requests::Base'
            end
          end
        end
      end
    end
  end
end
