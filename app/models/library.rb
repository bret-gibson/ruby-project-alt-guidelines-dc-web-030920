class Library < ActiveRecord::Base
    belongs_to :song
    belongs_to :user
end