require_relative 'config/environment'
require 'sinatra/activerecord/rake'

desc 'starts a console'
task :console do

  ActiveRecord::Base.logger = Logger.new(STDOUT)
  user1 = User.first
  user2 = User.last
  binding.pry
end