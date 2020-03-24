class Song < ActiveRecord::Base
    belongs_to :album 
    belongs_to :artist
    has_many :libraries
    has_many :users, through: :libraries


    def songs_by_artist
        i = 0
        puts "\nAll songs by #{self.artist.name}:"
         Song.all.select {|song| song.artist == self.artist}
         .each {|x| puts "#{i+=1}. #{x.title}"}
    end

    def remove_song
        system "clear"
        logo
        Library.where(song_id: self.id).destroy_all
        reload
    end

    def add_song(user)
        lib ||= Library.create(song_id: self.id, user_id: user.id)
    end

    def self.play_song
        pid = fork{exec 'afplay', '-v 0.5', "lib/11 - Everlong.mp3" }
    end

    def self.stop_song
        killall afplay
    end
end