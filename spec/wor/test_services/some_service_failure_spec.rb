require 'wor/requests/invalid_options_error'
require_relative 'some_service'
require_relative '../../support/mocks/responses.rb'

describe SomeService do
  describe 'failure' do
    # Only testing get method as Wor::Requests::Base http defined methods will
    # only defer when validating received opts. Then,
    # Wor::Requests::Base.request call will behave the same for all of them.
    describe 'get' do
      include_context 'STUB: get_failure'

      context 'when calling with attempting_to field defined' do
        context 'when calling with or without block' do
          subject(:service) { described_class.new }

          before do
            Spy.spy(service.logger, 'info')
            Spy.spy(service.logger, 'error')
            @response = service.get_with_log_with_block
          end

          it 'raises no exception' do
            expect{ @response }.not_to raise_error
          end

          it 'logger.info has been called once' do
            expect(service.logger.spied_info_counter).to be(1)
          end

          it 'logger.error has been called once' do
            expect(service.logger.spied_error_counter).to be(1)
          end

          it 'never executes the block' do
            expect(@response).not_to eq('helloworld')
          end

          it 'returns error with developer message' do
            expect(@response.message).to eq("#{described_class} got an error. See logs for more information.")
          end

          it 'returns error with response property' do
              expect(@response.response).not_to be_nil
          end

          it 'returns error with response property which has code' do
            expect(@response.response.code).not_to be_nil
          end

          it 'returns error with response property which has body' do
            expect(@response.response.body).not_to be_nil
          end
        end
      end

      context 'when calling without attempting_to field defined' do
        context 'when calling with or without block' do
          subject(:service) { described_class.new }

          before do
            Spy.spy(service.logger, 'info')
            Spy.spy(service.logger, 'error')
            @response = service.get_without_log_with_block
          end

          it 'raises no exception' do
            expect{ @response }.not_to raise_error
          end

          it 'logger.info should not have been called' do
            expect(service.logger.spied_info_counter).to be(0)
          end

          it 'logger.error should not have been called' do
            expect(service.logger.spied_error_counter).to be(0)
          end

          it 'never executes the block' do
            expect(@response).not_to eq('helloworld')
          end

          it 'returns error with developer message' do
            expect(@response.message).to eq("#{described_class} got an error. See logs for more information.")
          end

          it 'returns error with response property' do
              expect(@response.response).not_to be_nil
          end

          it 'returns error with response property which has code' do
            expect(@response.response.code).not_to be_nil
          end

          it 'returns error with response property which has body' do
            expect(@response.response.body).not_to be_nil
          end
        end
      end

      context 'when rescue is not defined' do
        subject(:service) { described_class.new }

        it 'raises exception' do
          expect{ service.get_without_rescue }.to raise_error(Wor::Requests::RequestError)
        end
      end
    end
  end
end
