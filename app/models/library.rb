class Library < ActiveRecord::Base
    belongs_to :song
    belongs_to :user

    # add validation for if there is no most popular song
    def self.most_added
        
        id = Library.all.map {|lib| lib.song_id}.group_by(&:itself).max_by {|key, value| value.count}
        most = Song.all.find {|song| song.id == id[0]}
        logo
        puts "--------------------------------"
        puts ""
        puts "--- The Most Popular Song Is ---"
        puts ""
        puts "--------------------------------"
        puts ""
        puts "#{most.title} - #{most.artist.name}"
        puts "It was added by #{id[1].count} users."
        puts "\n--------------------------------"
        2.times {puts ""}
        

        # array of all songs
        # call uniq
        # compare array of all songs with array of uniquies
        #if original array length is the same as array of unique - there is no most popular song

        Song.all
    end
end