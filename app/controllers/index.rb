get '/' do
  erb :index
end

get '/:username' do |username|
  @user = TwitterUser.find_by_username(username)
  if !@user
    @user = TwitterUser.create(username: username)
  end
  @tweets = @user.tweets.order('created_at DESC').limit(10)
  @new_tweets = nil
  erb :index
end


post '/:username' do |username|
  @user = TwitterUser.find_by_username(username)
  if @user.tweets_stale?
    @new_tweets = @user.fetch_tweets!
  end
  content_type :json
  @new_tweets.to_json
end