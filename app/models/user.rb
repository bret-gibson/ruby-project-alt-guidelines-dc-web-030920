class User < ActiveRecord::Base
    has_many :libraries
    has_many :songs, through: :libraries

   def display_songs
    puts self.songs.map {|x| "#{x.title} - #{x.artist}"}.join("\n")
   end
end