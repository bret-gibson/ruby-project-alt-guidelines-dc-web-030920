class Song < ActiveRecord::Base
    has_many :users, through: :library
end