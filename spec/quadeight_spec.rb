require 'spec_helper'

API_KEY = '8386c94e832b84206fd1adba087c3009284e62bb'


describe 'client functions' do
  let(:client) do
    Quadeight.create_client api_key: API_KEY
  end

  let(:mix_set) { client.get_mixes }

  describe 'EightGetter.api_key' do
    it 'sends a valid api key correctly' do
      expect(mix_set).to_not eq('You must use a valid API key.')
    end
  end

  describe 'client.get_mixes' do
    its 'is a mixset' do
      expect(mix_set.class).to eq(MixSet)
      mix_set.mixes.each do |m|
        expect(m.class).to eq(Mix)
        expect(m.id).to_not be_nil
      end
    end

    it 'has valid path' do
      expect(mix_set.path.class).to eq(String)
      expect(mix_set.path.length).to_not eq(0)
    end

    it 'has a name' do
      expect(mix_set.name.length).to_not eq(0)
    end

    its 'members all have path present' do
      mix_set.mixes.each do |m|
        expect(m.path.class).to eq(String)
      end
    end
  end

  describe 'client.user' do
    let(:mix) { mix_set.mixes.first }

    its 'user id should be present' do
      expect(mix.user.id).to_not be_nil
    end

    its 'user id to successfully retrieve a user object' do
      expect(mix.user.class).to eq(User)
    end
  end

  describe 'user.mixes' do
    let(:user) { mix_set.mixes.first.user }
    let(:user_mixes) { user.mixes }

    it 'should retrieve a mixset' do
      expect(user_mixes.class).to eq(MixSet)
      user_mixes.mixes.each do |mix|
        expect(mix.class).to eq(Mix)
      end
    end

  end

end
