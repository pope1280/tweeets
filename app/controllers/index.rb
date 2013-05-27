get '/' do
  erb :index
end

get '/:username' do |username|
  timeline = Twitter.user_timeline(username)
  @tweets = timeline.first(10)
  erb :index
end