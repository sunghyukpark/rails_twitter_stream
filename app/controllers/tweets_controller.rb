require 'tweetstream'

class TweetsController < ApplicationController

  # display all tweets with given word
  def index
    tweet = Tweet.new
    tweet.configure
    @statuses = tweet.make_sample_stream_request
  end

  # create instances of tweets while streaming
  def create
  end

  # destroy instances of tweets
  def destroy
  end

end
