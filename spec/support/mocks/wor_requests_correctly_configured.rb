RSpec.shared_context 'Wor::Requests correctly configured', shared_context: :metadata do
  before do
    Wor::Requests.logger = Logger.new(STDOUT)
    Wor::Requests.default_response_type = :json
  end
end
