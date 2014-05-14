require 'spec_helper'

API_KEY = '8386c94e832b84206fd1adba087c3009284e62bb'


describe 'client functions' do
  let(:client) do
    Quadeight.create_client api_key: API_KEY
  end

  let(:mix_set) { client.get_mixes }
  let(:mix) { mix_set.mixes.first }
  let(:track) { mix.first_song }

  describe 'EightGetter.api_key' do
    it 'sends a valid api key correctly' do
      expect(mix_set).to_not eq('You must use a valid API key.')
    end
  end

  describe 'EightGetter.generate_play_token' do
    it 'receives a valid play token from api' do
      # this random `client` is here to ensure that the api key is set on
      # EightGetter, its needed to generate a play token
      client
      expect(EightGetter.generate_play_token).to match(/[0-9]{9}/)
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
  end

  describe 'MixSet.initialize' do
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

  describe 'Mix.each_song' do
    it 'should iterate through each song, and each song should be valid' do
      mix.each_track(:report) do |track|
        expect(track.class).to eq(Track)
        expect(track.track_file_stream_url).to match(/http.*/)
        puts "track name #{track.name} => #{track.track_file_stream_url}"
      end
    end
  end

  describe 'Track.initialize' do
    it 'creates a track from available data' do
      expect(track.class).to eq(Track)
      expect(track.name.length).to_not eq(0)
      expect(track.track_file_stream_url.length).to_not eq(0)
    end
  end

  describe 'Track.export_track' do
    it 'saves a track with proper (available) metadata' do
    end
  end
end
