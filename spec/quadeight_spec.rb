require 'spec_helper'

describe Quadeight do
  API_KEY = '8386c94e832b84206fd1adba087c3009284e62bb'

  let(:client) do
    Quadeight.create_client api_key: API_KEY
  end

  it 'correctly authenticates' do
    mixes = client.get_mixes
    mixes.should_not eq('You must use a valid API key.')
  end

  it 'gets mixes correctly' do
    client.get_mixes
    mixes.each do |m|
      m.class.should eq(Mix)
    end
  end
end
