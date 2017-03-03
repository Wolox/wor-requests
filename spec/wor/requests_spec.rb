require 'spec_helper'

describe Wor::Requests do
  describe '.config' do
    it 'has configurations' do
      expect(described_class.config).not_to be nil
    end

    it 'has logger' do
      expect(described_class.config[:logger]).not_to be nil
    end
  end

  describe '.configure' do
    let(:new_logger) { 'NEW_LOGGER' }

    before do
      described_class.configure do |config|
        config.logger = new_logger
      end
    end

    it 'can be configured' do
      expect(described_class.config[:logger]).to eq(new_logger)
    end
  end
end
