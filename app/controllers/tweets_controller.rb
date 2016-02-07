require 'tweetstream'

class TweetsController < ApplicationController

  def index
    # declare new Tweet object defined in tweet.rb
    tweet_client = Tweet.new

    # make request, filter tweets
    tweet_client.make_stream_request(1)

    # hash
    #  - key: tweet word
    #  - value: frequency of word

    @store = tweet_client.store
    @popular = tweet_client.popular
  end

end
