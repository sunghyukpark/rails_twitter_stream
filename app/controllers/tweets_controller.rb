require 'tweetstream'

class TweetsController < ApplicationController

  def index

    # declare new Tweet object defined in tweet.rb
    tweet_client = Tweet.new

    # unfiltered tweets
    uf_tweets = tweet_client.make_stream_request

    # array of filtered tweet words
    @tweet_words = tweet_client.filter_tweet_and_store_words(uf_tweets)

    @store = tweet_client.store
  end

end
