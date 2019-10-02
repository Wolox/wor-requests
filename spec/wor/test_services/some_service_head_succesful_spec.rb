require 'spec_helper'
require_relative 'some_service'
require_relative '../../support/mocks/responses.rb'

# rubocop:disable BlockLength
describe SomeService do
  describe 'head_successful' do
    # Only testing get method as Wor::Requests::Base http defined methods will
    # only defer when validating received opts. Then,
    # Wor::Requests::Base.request call will behave the same for all of them.
    describe 'get' do
      include_context 'STUB: get_head_successful'
      subject(:service) { described_class.new }

      context 'when calling with attempting_to field defined' do
        before do
          Spy.spy(service.logger, 'info')
          @response = service.method_with_log_without_block
        end

        it 'raises no exception' do
          expect { @response }.not_to raise_error
        end

        it 'logger.info has been called twice' do
          expect(service.logger.spied_info_counter).to be(2)
        end
      end

      context 'when calling without attempting_to field defined' do
        before do
          Spy.spy(service.logger, 'info')
          @response = service.method_without_log_without_block
        end

        it 'raises no exception' do
          expect { @response }.not_to raise_error
        end

        it 'logger.info should not have been called' do
          expect(service.logger.spied_info_counter).to be(0)
        end
      end
    end
  end
end
