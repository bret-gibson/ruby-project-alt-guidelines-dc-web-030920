class User < ActiveRecord::Base
    has_many :songs, through: :library
end