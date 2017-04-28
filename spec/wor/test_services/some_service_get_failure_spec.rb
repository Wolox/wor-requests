require 'wor/requests/invalid_options_error'
require_relative 'some_service'

describe SomeService do
  describe 'failure' do
    describe 'get' do
      context 'when invalid option set for method to hash' do
        subject(:service) { described_class.new }

        context 'without rescue' do
          it 'raises exception' do
            expect{ service.get_with_unpermitted_params }.to raise_error(Wor::Requests::InvalidOptionsError)
          end
        end

        context 'with rescue' do
          let(:error) { service.get_with_unpermitted_params_with_rescue }

          it 'returns an error' do
            expect(error).not_to be_nil
          end

          it 'returns an error with valid options' do
            expect(error.valid).to eq(Wor::Requests::Base::GET_ATTRIBUTES)
          end

          it 'returns an error with invalid options' do
            expect(error.invalid).not_to be_empty
          end
        end
      end
    end
  end
end
