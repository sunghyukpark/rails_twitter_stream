require 'tweetstream'

class TweetsController < ApplicationController

  def index

    # declare new Tweet object defined in tweet.rb
    tweet = Tweet.new
    tweet.configure

    # unfiltered tweets
    uf_tweets = tweet.make_stream_request

    # array of filtered tweet words
    @tweet_words = tweet.filter_tweet(uf_tweets)
  end

end
