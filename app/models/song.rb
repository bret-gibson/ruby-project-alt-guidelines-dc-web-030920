class Song < ActiveRecord::Base
    belongs_to :album 
    belongs_to :artist
    has_many :libraries
    has_many :users, through: :libraries


    def songs_by_artist
        i = 0
        puts "\nAll songs by #{self.artist.name} in your Library"
        Song.all.select {|song| song.artist == self.artist}
        .each {|x| puts "#{i+=1}. #{x.title}"}
        puts "\n-----------------------------------------------------"
        Menu.selector(i)
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

    def play_song
        Launchy.open(self.preview_url)
        puts "Now playing preview of #{self.title} by #{self.artist.name}"
        puts "Press any key to go back to the song menu"
        gets.chomp
        logo
    end

    def self.stop_song
        killall afplay
    end
end