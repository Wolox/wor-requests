# require 'spec_helper'
# require 'wor/requests/base.rb'
# require_relative '../../support/mocks/correctly_instanciated_base.rb'
#
# describe Wor::Requests::Base do
#   #   - get(opts = {}, &block)
#   describe 'get' do
#     context 'when child class is correctly defined' do
#       include_context 'STUB: correctly_instanciated_base'
#       before do
#         described_class.new.post(path: '', body: { a: 'some_a', b: 'some_b' }.to_json,
#                                  headers: { 'Content-Type' => 'application/json' },
#                                  attempting_to: 'request some a and b')
#       end
#       it 'makes the request' do
#         expect(a_request(:post, target_url)).to have_been_made.once
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
