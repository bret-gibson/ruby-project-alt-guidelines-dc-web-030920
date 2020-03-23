class Song < ActiveRecord::Base
    has_many :libraries
    has_many :users, through: :libraries
end