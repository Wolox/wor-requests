# require 'spec_helper'
# require_relative 'github_service.rb'
# require_relative '../../support/mocks/github_repositories.rb'
# require_relative '../../support/mocks/github_repositories_bad_request.rb'
# require_relative '../../support/mocks/wor_requests_correctly_configured.rb'
#
# describe GithubService do
#   describe 'get' do
#     context 'when has attempting_to defined' do
#
#       context 'and external api responds correctly' do
#         include_context 'STUB: github_successful_repositories'
#
#         before do
#           let(:response) { described_class.new.repositoriesWithLog('enanodr') }
#         end
#
#         it 'raises no exception' do
#           expect(response).not_to raise_error
#         end
#
#         it 'returns the repos' do
#           expect(response['repos']).to eq(%w[repo1 repo2])
#         end
#       end
#
#       context 'and external api responds with error code' do
#         include_context 'STUB: github_repositories bad request'
#         it 'logs the error' do
#           expect(Wor::Requests.logger).to receive(:error).with(/ERROR when trying to/)
#           described_class.new.repositoriesWithLog('Enanodr')
#         end
#         it 'raises no exception' do
#           expect { described_class.new.repositoriesWithLog('Enanodr') }.not_to raise_error
#         end
#       end
#     end
#   end
#   #   - post(opts = {}, &block)
#   describe 'post' do
#   end
#   #   - patch(opts = {}, &block)
#   describe 'patch' do
#   end
#   #   - put(opts = {}, &block)
#   describe 'put' do
#   end
#   #   - delete(opts = {}, &block)
#   describe 'delete' do
#   end
# end
