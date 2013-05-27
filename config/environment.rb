# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'

require 'sinatra'
require "sinatra/reloader" if development?

require 'erb'
require 'twitter'

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

# Set up the database and models
require APP_ROOT.join('config', 'database')

#Twitter stuff



Twitter.configure do |config|
  config.consumer_key = "ffLbJ2X7UiFEp3qoO8BWw"
  config.consumer_secret = "VAn3HYITDcVUFxXrNha3kyT5Cgwb5RFPZqR4KjPGKc"
  config.oauth_token = "246987034-jDxkZcSYHWXGShuTlAvU8rivbE5j0iNYe1qQJWyI"
  config.oauth_token_secret = "zT2KAz8vnENRT4t0qwnbFNxhFOj9lFdnKp9f6RR8tE"
end