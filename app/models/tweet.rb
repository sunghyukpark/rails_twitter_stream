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

  def make_sample_stream_request
    statuses = []
    TweetStream::Client.new.sample do |status, client|
      # filter language, English only
      client.filter(:lang => "en")
      statuses << status
      client.stop if statuses.size >= 20
    end
    return statuses
  end

  # takes array of tweet texts and filter according to standard
  def filter_tweet(tweets)
    filtered_tweets = []

    tweets.each do |tweet|
      filter_lang(tweet)
      # filter_stopwords(tweet)
      filtered_tweets << tweet
    end

    return filtered_tweets
  end

  # collect words and keep track of frequency
  def map_word
  end


  private
  def filter_lang(tweet)
    tweet.text.split(" ").each do |word|
      # remove @
      word.gsub!(/[@]/, "")
    end
  end

  def filter_stopwords(tweet)
    #and, the, me, this, that, these, a, an, you, he, she, they, them, are, is, him, his, her, their, them, its, it, mine, us, my, your, theirs, yours, at, in, to, from, on
  end

  # stream
  # count 10 most frequest
  # track frequency of each
  # make instances of tweat

end
