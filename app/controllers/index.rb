get '/' do
  erb :index
end

get '/:username' do |username|
  @user = TwitterUser.find_by_username(params[:username])
  if !@user
    @user = TwitterUser.create(username: username)
  end
  if @user.tweets_stale?
    @user.fetch_tweets!
  end

  @tweets = @user.tweets.limit(10)

  erb :index
end