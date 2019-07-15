require 'bundler/setup'
Bundler.require

ENV['SINATRA_ENV'] ||= "development"

require_all 'app'
unless ENV['RACK_ENV'] =='production'
require 'dotenv' 
Dotenv.load
end