require 'rails_helper'

RSpec.describe TweetApi do
  let(:tweet_api){TweetApi.new}

  context 'when initialized' do
    it 'creates empty store hash' do
      expect(tweet_api.store).to eq(Hash.new(0))
    end

    it 'creates empty popular hash' do
      expect(tweet_api.popular).to eq(Hash.new(0))
    end
  end
end
