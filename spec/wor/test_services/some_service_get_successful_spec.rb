require_relative 'some_service'
require_relative '../../support/mocks/successful_responses.rb'

describe SomeService do
  describe 'successful' do
    describe 'get' do
      include_context 'STUB: get_successful'

      context 'when calling with attempting_to field defined' do
        context 'when calling without block' do
          subject(:service) { described_class.new }

          before do
            Spy.spy(service.logger, 'info')
            @response = service.get_with_log_without_block
          end

          it 'raises no exception' do
            expect{ @response }.not_to raise_error
          end

          it 'logger.info has been called twice' do
            expect(service.logger.spied_info_counter).to be(2)
          end

          it 'returns response with array' do
            expect(@response).to have_key('array')
          end

          it 'returns array with array format' do
            expect(@response['array']).to eq(%w[hello world])
          end
        end

        context 'when calling with block' do
          subject(:service) { described_class.new }

          before do
            Spy.spy(service.logger, 'info')
            @response = service.get_with_log_with_block
          end

          it 'raises no exception' do
            expect{ @response }.not_to raise_error
          end

          it 'logger.info has been called twice' do
            expect(service.logger.spied_info_counter).to be(2)
          end

          it 'returns processed by block response' do
            expect(@response).to eq('helloworld')
          end
        end
      end

      context 'when calling without attempting_to field defined' do
        context 'when calling without block' do
          subject(:service) { described_class.new }

          before do
            Spy.spy(service.logger, 'info')
            @response = service.get_without_log_without_block
          end

          it 'raises no exception' do
            expect{ @response }.not_to raise_error
          end

          it 'logger.info should not have been called' do
            expect(service.logger.spied_info_counter).to be(0)
          end

          it 'returns response with array' do
            expect(@response).to have_key('array')
          end

          it 'returns array with array format' do
            expect(@response['array']).to eq(%w[hello world])
          end
        end

        context 'when calling with block' do
          subject(:service) { described_class.new }

          before do
            Spy.spy(service.logger, 'info')
            @response = service.get_without_log_with_block
          end

          it 'raises no exception' do
            expect{ @response }.not_to raise_error
          end

          it 'logger.info has been called twice' do
            expect(service.logger.spied_info_counter).to be(0)
          end

          it 'returns processed by block response' do
            expect(@response).to eq('helloworld')
          end
        end
      end
    end
  end
end
