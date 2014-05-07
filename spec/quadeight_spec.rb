require 'spec_helper'

describe Quadeight do
  it 'correctly authenticates' do
    api_key = '8386c94e832b84206fd1adba087c3009284e62bb'
    @client = Quadeight.create_client api_key: api_key
    mixes = @client.get_mixes
    mixes.should_not eq('You must use a valid API key.')
  end

  it 'answers hello world' do
    Quadeight.hello.should eq('world')
  end
end
