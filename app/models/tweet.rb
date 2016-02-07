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
    client = TweetStream::Client.new
    client.sample do |status, client|
      statuses << status
      client.stop if statuses.size >= 20
    end
    return statuses
  end

  # takes array of tweet texts and filter according to standard
  def filter_tweet(tweets)
    total_words = []
    tweets.each do |tweet|
      if filter_word(tweet) != nil
        tweet_words = filter_word(tweet)
        tweet_words.each do |word|
          total_words << word
        end
      end
    end
    return total_words
  end

  # collect words and keep track of frequency
  def map_word
  end


  private

  def filter_word(tweet)
    # remove '@''
    text = tweet.text.dup
    text.gsub!(/[@]/, "")
    # select English word only
    p text.split(" ").select!{|v| v=~ /^[a-zA-Z]*$/}
    text_arr = text.split(" ").select!{|v| v =~ /^[a-zA-Z0-9]*$/}
    return text_arr
  end

  def filter_stopwords(tweet)
    #and, the, me, this, that, these, a, an, you, he, she, they, them, are, is, him, his, her, their, them, its, it, mine, us, my, your, theirs, yours, at, in, to, from, on
  end

  # stream
  # count 10 most frequest
  # track frequency of each
  # make instances of tweat

end
