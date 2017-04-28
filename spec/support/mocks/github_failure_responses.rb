RSpec.shared_context 'STUB: github_get_failure_repositories', shared_context: :metadata do
  before do
    stub_request(:get, /.*repos.*/)
      .to_return(status: 400, body: { error: 'Some bad request message' }.to_json, headers: {})
  end
end
