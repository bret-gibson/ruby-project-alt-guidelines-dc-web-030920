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
        i = Menu.selector(i).to_i
        i -= 1

        song_hash = {}
        song_hash[:song] = album_hash["tracks"]["data"][i]["title"]
        song_hash[:artist] = Artist.where(name: album_hash["artist"]["name"])[0]
        song_hash[:album] = Album.where(name: album_hash["title"])[0]
        song_hash[:preview_link] = album_hash["tracks"]["data"][i]["preview"]
        Menu.song_sub_menu(song_hash)
        Menu.go_back_with_any_key
    end
end