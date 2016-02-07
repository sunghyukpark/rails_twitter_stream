require 'tweetstream'

class Tweet < ActiveRecord::Base
  attr_accessor :store, :popular

  STOP_WORDS_LIST = ["i", "and", "the", "me", "this", "that", "these", "a", "an", "you", "he", "she", "they", "them", "are", "is", "him", "his", "her", "their", "them", "its", "it", "mine", "our", "us", "my", "your", "theirs", "yours","be","been","being","have", "at", "in", "to","for","but","else","would","should","could", "from","who","when", "where", "why", "what","with","how","some","gonna", "on", "will","than","un", "just","not", "rt", "en","la", "los","las", "de" ,"del", "una", "con", "que", "para", "por", "como"]

  # initialize
  # @store -> hash to save filtered word and its frequency
  # request token configuration

  def initialize
    @store = Hash.new(0)
    @popular = Hash.new

    TweetStream.configure do |config|
      config.consumer_key       = ENV['CONSUMER_KEY']
      config.consumer_secret    = ENV['CONSUMER_SECRET']
      config.oauth_token        = ENV['ACCESS_TOKEN']
      config.oauth_token_secret = ENV['ACCESS_TOKEN_SECRET']
      config.auth_method        = :oauth
    end
  end


  # makes stream request and get tweet objects
  #  - once 5 min steaming is done
  #     - client.stop
  #     - filter tweet and store all words in @store
  #     - store popular words and its freq in @popular

  def make_stream_request(min)
    statuses = []
    client = TweetStream::Client.new

    EM.run do
      EM::PeriodicTimer.new(60*min) do
        client.stop
        filter_tweet_and_store_words(statuses)
        pick_popular_words
      end

      client.sample do |status, client|
        statuses << status
      end
    end
  end


  # filter tweet and store words
  #    - filter_word: remove '@' and select alpha-only words
  #    - filter_stop_word: remove stop words and words of length < 3


  def filter_tweet_and_store_words(tweets)
    total_words = []

    tweets.each do |tweet|
      if filter_word(tweet) != nil
        eng_words = filter_word(tweet)
        filtered = filter_stop_word(eng_words)
        filtered.each do |word|
          store_word_freq(word)
          total_words << word
        end
      end
    end
    return total_words
  end



  private

  def filter_word(tweet)
    # remove '@''
    text = tweet.text.dup
    text.gsub!(/[@]/, "")

    # select English word only
    filtered = text.split(" ").select!{|v| v =~ /^[a-zA-Z]*$/}

    return filtered
  end


  def filter_stop_word(words)
    filtered = []
    words.each do |word|
      word.downcase!
      filtered << word unless (STOP_WORDS_LIST.include?(word) || word.length < 3)
    end
    return filtered
  end

  def store_word_freq(word)
    @store[word] += 1
  end

  def pick_popular_words
    nested_popular = @store.sort_by{|key, value| -value}.first(10)
    nested_popular.each do |popular|
      word = popular[0]
      freq = popular[1]

      @popular[word] = freq
    end
  end


end
