class Album < ActiveRecord::Base 
    has_many :songs
    belongs_to :artist

    def self.show_album_info(pick)
        logo
        album_hash = album_request(pick.album.deezer_id)
        i = 0
        puts "****************************  ALBUM INFO  **********************************"
        puts "Album Name: #{album_hash["title"]}"
        puts "Album Artist Name: #{album_hash["artist"]["name"]}"
        puts "Songs (#{album_hash["nb_tracks"]}):"
        album_hash["tracks"]["data"].each do |song|
            song_time = Time.at(song["duration"]).utc.strftime("%M:%S")
            puts "#{i+=1}. #{song["title"]} - #{song_time}"
        end
        puts "****************************************************************************"
        Menu.go_back_with_any_key
    end
end