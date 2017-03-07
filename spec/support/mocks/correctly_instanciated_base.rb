RSpec.shared_context 'STUB: correctly_instanciated_base', shared_context: :metadata do
  let!(:target_url) { Faker::Internet.url }

  before do
    allow_any_instance_of(Wor::Requests::Base).to receive(:base_url).and_return(target_url)
    stub_request(:post, target_url)
      .with(body: { a: 'some_a', b: 'some_b' }, headers: { 'Content-Type' => 'application/json' })
      .to_return(body: { some_response_key: 'some_response_value' }.to_json)
  end
end
