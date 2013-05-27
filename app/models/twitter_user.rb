class TwitterUser < ActiveRecord::Base
  has_many :tweets

  def fetch_tweets!
    tweets = Twitter.user_timeline(self.username)
    tweets.each do |tweet|
      Tweet.create(tweet: tweet[:text], twitter_user_id: self.id)
    end
  end

  def last_tweet
    tweets = Twitter.user_timeline(self.username, {count: 1})
    tweets.first[:text]
  end

  def tweets_stale?
    time = DateTime.now
    if self.tweets.empty?
      return true
    else
      self.tweets.order('created_at DESC').last.tweet != last_tweet
    end
  end
end
