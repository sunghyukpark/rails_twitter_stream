require 'tweetstream'

class Tweet < ActiveRecord::Base

  def configure
    TweetStream.configure do |config|
      config.consumer_key       = ENV['CONSUMER_KEY']
      config.consumer_secret    = ENV['CONSUMER_SECRET']
      config.oauth_token        = ENV['ACCESS_TOKEN']
      config.oauth_token_secret = ENV['ACCESS_TOKEN_SECRET']
      config.auth_method        = :oauth
    end
  end

  def make_userstream_request
    TweetStream::Client.new.sample do |status|

      # puts "#{status.text}"
    end
  end

  # stream
  # count 10 most frequest
  # track frequency of each
  # make instances of tweat

end
