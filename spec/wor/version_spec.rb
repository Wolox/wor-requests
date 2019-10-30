require 'spec_helper'

describe Wor::Requests::VERSION do
  subject(:version) { Wor::Requests::VERSION }

  it 'has a version number' do
    expect(version).not_to be nil
  end

  it 'has the correct version number' do
    expect(version).to eq('0.1.2')
  end
end
