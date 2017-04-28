require_relative 'github_service'
require_relative '../../support/mocks/github_failure_responses.rb'

describe GithubService do
  describe 'failure' do
    describe 'get' do
      include_context 'STUB: github_get_failure_repositories'

      context 'when calling with attempting_to field defined' do
        context 'when calling with or without block' do
          subject(:service) { described_class.new }

          before do
            Spy.spy(service.logger, 'info')
            Spy.spy(service.logger, 'error')
            @response = service.repositories_with_log_with_block('enanodr')
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
            expect(@response).not_to eq('repo1repo2')
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
            @response = service.repositories_without_log_with_block('enanodr')
          end

          it 'raises no exception' do
            expect{ @response }.not_to raise_error
          end

          it 'logger.info has been called once' do
            expect(service.logger.spied_info_counter).to be(0)
          end

          it 'logger.error has been called once' do
            expect(service.logger.spied_error_counter).to be(0)
          end

          it 'never executes the block' do
            expect(@response).not_to eq('repo1repo2')
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
          expect{ service.repositories_without_rescue('enanodr') }.to raise_error(Wor::Requests::RequestError)
        end
      end
    end
  end
end
