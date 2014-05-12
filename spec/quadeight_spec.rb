require 'spec_helper'

describe Quadeight do
  API_KEY = '8386c94e832b84206fd1adba087c3009284e62bb'

  let(:client) do
    Quadeight.create_client api_key: API_KEY
  end

  it 'correctly authenticates' do
    mixes = client.get_mixes
    expect(mixes).to_not eq('You must use a valid API key.')
  end

  it 'gets mixes correctly' do
    mixes = client.get_mixes
    mixes.each do |m|
      expect(m.class).to eq(Mix)
      expect(m.id).to_not be_nil
      expect(m.restful_url.class).to eq(String)
    end
  end
end
