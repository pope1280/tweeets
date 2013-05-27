get '/' do
  erb :index
end

get '/:username' do |username|
  @user = TwitterUser.find_by_username(username)
  if !@user
    @user = TwitterUser.create(username: username)
  end
  if @user.tweets_stale?
    @user.fetch_tweets!
  end

  @tweets = @user.tweets.order('created_at DESC').limit(10)

  erb :index
end