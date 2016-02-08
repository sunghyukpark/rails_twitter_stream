<h1>Rails Twitter Stream</h1>

<h3> Intro </h3>
This app uses Twitter Streaming api and 'tweetstream' gem to get live tweets results.

<h3> Installation </h3>
1. configure your tokens in /app/models/tweets.rb - this app uses dotenv gem (https://github.com/bkeepers/dotenv). Include '.env' file in your root directory, and save twitter tokens (https://apps.twitter.com/). Don't forget to include .env in your .gitignore file. 
2. 'bundle install'
3. 'rails s' 
4. Visit root page (localhost:3000) to see list of tweets and counts.
5. Note - the app is set to receive 1 min of streamed tweet results. If you want to change default min, go to /app/controllers/tweets_controller.rb and change min number in make_stream_request method. If streaming stops suddenly, the app would display saved results so far(tweet words saved in instance variable of Tweet model -> @store, @popular). 

<h3> Improvements needed </h3>
1. Takes too much time loading the results page. Live update and visualization of data would be great to implement.
2. Refactoring
3. Model, Controller renaming (implemented client for api so far. Tweet -> TweetClient)

<h3> Gems </h3>
1. dotenv-rails
2. awesome-print
3. tweetstream
4. eventmachine


<h3> What you can expect </h3>


