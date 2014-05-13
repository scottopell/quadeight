require 'spec_helper'

API_KEY = '8386c94e832b84206fd1adba087c3009284e62bb'


describe 'client functions' do
  let(:client) do
    Quadeight.create_client api_key: API_KEY
  end

  let(:mixes) { client.get_mixes }

  describe 'EightGetter.api_key' do
    it 'sends a valid api key correctly' do
      expect(mixes).to_not eq('You must use a valid API key.')
    end
  end

  describe 'client.get_mixes' do
    its 'members are all valid' do
      mixes.each do |m|
        expect(m.class).to eq(Mix)
        expect(m.id).to_not be_nil
      end
    end

    its 'members all have rest url present' do
      mixes.each do |m|
        expect(m.path.class).to eq(String)
      end
    end
  end

  describe 'client.user' do
    let(:mix) { mixes.first }

    its 'user id should be present' do
      expect(mix.user.id).to_not be_nil
    end

    its 'user id to successfully retrieve a user object' do
      expect(mix.user.class).to eq(User)
    end
  end

  describe 'user.mixes' do
    let(:user) { mixes.first.user }
    let(:user_mixes) { user.mixes }

    it 'should retrieve an array of mixes' do
      expect(user_mixes.class).to eq(Array)
      user_mixes.each do |mix|
        expect(mix.class).to eq(Mix)
      end
    end
  end

end
