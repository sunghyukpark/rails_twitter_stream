require 'tweetstream'

class TweetsController < ApplicationController

  # display all tweets with given word
  def index
    tweet = Tweet.new
    tweet.configure

    # unfiltered statuses (should filter lang(en-only), unnecessary words)
    uf_statuses = tweet.make_sample_stream_request
    @statuses = tweet.filter_tweet(uf_statuses)

  end

  # create instances of tweets while streaming
  def create
  end

  # destroy instances of tweets
  def destroy
  end

end
