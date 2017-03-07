RSpec.shared_context 'STUB: github_get_successful_repositories', shared_context: :metadata do
  before do
    stub_request(:get, /.*repos.*/)
      .to_return(status: 200, body: { repos: %w[repo1 repo2] }.to_json, headers: {})
  end
end
