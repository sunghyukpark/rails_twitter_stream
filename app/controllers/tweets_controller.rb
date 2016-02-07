require 'tweetstream'

class TweetsController < ApplicationController

  # display all tweets with given word
  def index
    tweet = Tweet.new
    tweet.configure

    # unfiltered statuses (should filter lang(en-only), unnecessary words)
    uf_tweets = tweet.make_sample_stream_request

    @tweet_words = tweet.filter_tweet(uf_tweets)
  end

  # create instances of tweets while streaming
  def create
  end

  # destroy instances of tweets
  def destroy
  end

end
