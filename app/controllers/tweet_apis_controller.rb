require 'tweetstream'

class TweetApisController < ApplicationController

  def index
    # declare new Tweet object defined in tweet.rb
    tweet_client = TweetApi.new

    # make request, filter tweets
    tweet_client.make_stream_request(0.5)

    # hash
    #  - key: tweet word
    #  - value: frequency of word
    @store = tweet_client.store
    @popular = tweet_client.popular
  end

end
