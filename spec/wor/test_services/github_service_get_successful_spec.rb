require_relative 'github_service'
require_relative '../../support/mocks/github_successful_responses.rb'

describe GithubService do
  describe 'successful' do
    describe 'get' do
      include_context 'STUB: github_get_successful_repositories'

      context 'when calling with attempting_to field defined' do
        context 'when calling without block' do
          subject(:service) { described_class.new }

          before do
            Spy.spy(service.logger, 'info')
            @response = service.repositories_with_log_without_block('enanodr')
          end

          it 'raises no exception' do
            expect{ @response }.not_to raise_error
          end

          it 'logger.info has been called twice' do
            expect(service.logger.spied_info_counter).to be(2)
          end

          it 'returns response with repos' do
            expect(@response).to have_key('repos')
          end

          it 'returns repos with array format' do
            expect(@response['repos']).to eq(%w[repo1 repo2])
          end
        end

        context 'when calling with block' do
          subject(:service) { described_class.new }

          before do
            Spy.spy(service.logger, 'info')
            @response = service.repositories_with_log_with_block('enanodr')
          end

          it 'raises no exception' do
            expect{ @response }.not_to raise_error
          end

          it 'logger.info has been called twice' do
            expect(service.logger.spied_info_counter).to be(2)
          end

          it 'returns processed by block response' do
            expect(@response).to eq('repo1repo2')
          end
        end
      end

      context 'when calling without attempting_to field defined' do
        context 'when calling without block' do
          subject(:service) { described_class.new }

          before do
            Spy.spy(service.logger, 'info')
            @response = service.repositories_without_log_without_block('enanodr')
          end

          it 'raises no exception' do
            expect{ @response }.not_to raise_error
          end

          it 'logger.info should not have been called' do
            expect(service.logger.spied_info_counter).to be(0)
          end

          it 'returns response with repos' do
            expect(@response).to have_key('repos')
          end

          it 'returns repos with array format' do
            expect(@response['repos']).to eq(%w[repo1 repo2])
          end
        end

        context 'when calling with block' do
          context 'when calling with block' do
            subject(:service) { described_class.new }

            before do
              Spy.spy(service.logger, 'info')
              @response = service.repositories_without_log_with_block('enanodr')
            end

            it 'raises no exception' do
              expect{ @response }.not_to raise_error
            end

            it 'logger.info has been called twice' do
              expect(service.logger.spied_info_counter).to be(0)
            end

            it 'returns processed by block response' do
              expect(@response).to eq('repo1repo2')
            end
          end
        end
      end
    end
  end
end
