RSpec.shared_context 'STUB: get_successful', shared_context: :metadata do
  before do
    stub_request(:get, /.*mypath/)
      .to_return(status: 200, body: { array: %w[hello world] }.to_json, headers: {})
  end
end
