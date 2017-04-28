RSpec.shared_context 'STUB: get_failure', shared_context: :metadata do
  before do
    stub_request(:get, /.*mypath/)
      .to_return(status: 400, body: { error: 'Some bad request message' }.to_json, headers: {})
  end
end
