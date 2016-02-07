require 'tweetstream'

class TweetsController < ApplicationController

  def index

    # declare new Tweet object defined in tweet.rb
    tweet_client = Tweet.new

    # configure tokens
    tweet_client.configure

    # unfiltered tweets
    uf_tweets = tweet_client.make_stream_request

    # array of filtered tweet words
    @tweet_words = tweet_client.filter_tweet(uf_tweets)
  end

end
