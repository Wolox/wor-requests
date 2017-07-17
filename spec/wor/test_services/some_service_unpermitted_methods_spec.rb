require_relative 'some_service_with_unpermitted_methods'
require_relative '../../support/mocks/responses.rb'

describe SomeServiceWithUnpermittedMethods do
  include_context 'STUB: get_successful'
  context 'when calling with an unpermitted method' do
    subject(:service) { described_class.new }
    it 'raises an exception' do
      @response = service.method_without_log_with_block
      expect { @response }.not_to raise_error
    end
  end
end
