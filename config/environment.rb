require 'bundler'
require 'pry'
require 'json'
require 'rest-client'
require 'awesome_print'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all './app/models/'
require_all './lib/'
# require_all './bin/'

# ActiveRecord::Base.logger = Logger.new(STDOUT)
old_logger = ActiveRecord::Base.logger

ActiveRecord::Base.logger = nil