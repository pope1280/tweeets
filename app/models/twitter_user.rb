class TwitterUser < ActiveRecord::Base
  has_many :tweets
  has_many :followers

  def fetch_tweets!
    tweets = Twitter.user_timeline(self.username)
    new_tweets = []
    tweets.each do |tweet|
      exist = Tweet.find_by_tweet(tweet[:text])
      new_tweets << Tweet.create(tweet: tweet[:text], twitter_user_id: self.id) if !exist
    end
    new_tweets
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

  def grab_followers
    followers = Twitter.followers(self.username, {count: 200})
    followers.users.each do |user|
      follower = TwitterUser.find_or_create_by_username(user.screen_name)
      exist = Follower.find_by_twitter_user_id_and_twitter_follower_id(self.id, follower.id)
      if !exist
        Follower.create(twitter_user_id: self.id, twitter_follower_id: follower.id)
      end
    end
  end

  def followers
    grab_followers
    followers = []
    relations = Follower.where("twitter_user_id = ?", self.id)
    relations.each do |relation|
      followers << TwitterUser.find(relation.twitter_follower_id)
    end
    followers
  end
end
