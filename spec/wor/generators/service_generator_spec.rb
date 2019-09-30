require 'generator_spec'
require 'generators/wor/requests/service_generator'

# rubocop:disable Metrics/BlockLength
describe Wor::Requests::Generators::ServiceGenerator, type: :generator do
  context 'generating a service with a name' do
    destination File.expand_path('../../../../tmp', __FILE__)
    arguments %w(book)

    before(:all) do
      prepare_destination
      run_generator
    end

    # rubocop:disable Style/BlockDelimiters
    it 'generates the correct structure for the service' do
      expect(destination_root).to(have_structure {
        no_file 'book_service.rb'
        directory 'app' do
          no_file 'book_service.rb'
          directory 'services' do; end
        end
      })
    end
    # rubocop:enable Style/BlockDelimiters
  end

  context 'generating a service with a name and module' do
    destination File.expand_path('../../../../tmp', __FILE__)
    arguments %w(book --module OpenLibrary)

    before(:all) do
      prepare_destination
      run_generator
    end

    # rubocop:disable Style/BlockDelimiters
    it 'generates the correct structure for the service' do
      expect(destination_root).to(have_structure {
        no_file 'book_service.rb'
        directory 'app' do
          no_file 'book_service.rb'
          directory 'services' do
            no_file 'book_service.rb'
            directory 'open_library' do; end
          end
        end
      })
    end
    # rubocop:enable Style/BlockDelimiters
  end
end
