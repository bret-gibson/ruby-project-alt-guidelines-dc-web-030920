class Album < ActiveRecord::Base 
    has_many :songs
    belongs_to :artist

    def self.show_album_info(pick)
        Menu.logo
        album_hash = self.album_request(pick.album.deezer_id)
        i = 0
        puts "*************************************".green +  " ALBUM INFO " + "****************************************".green
        puts "\nAlbum Name: #{album_hash["title"]}"
        puts "Album Artist Name: #{album_hash["artist"]["name"]}"
        puts "No. of Tracks (#{album_hash["nb_tracks"]})\n\n"
        puts "#   Title                                                                          Length\n\n"
        album_hash["tracks"]["data"].each do |song|
            song_time = Time.at(song["duration"]).utc.strftime("%M:%S")
            song_title = song["title"]
            num = i+=1
            line = "#{song_title}#{album_lines(song_title.length)}#{song_time}"
            if num < 10
                puts "#{num}.  #{line}"
            else
                puts "#{num}. #{line}"
            end
        end
        puts "\n******************************************************************************************".green
        i = Menu.selector(i).to_i
        i -= 1


        artist = Artist.where(name: album_hash["artist"]["name"])[0]
        if artist == nil
            artist = Artist.create(name: album_hash["artist"]["name"]) 
        end




        song_hash = {}
        song_hash[:song] = album_hash["tracks"]["data"][i]["title"]
        song_hash[:artist] = artist
        song_hash[:album] = Album.where(name: album_hash["title"])[0]
        song_hash[:preview_link] = album_hash["tracks"]["data"][i]["preview"]
        # binding.pry
        Menu.song_sub_menu(song_hash)
        Menu.go_back_with_any_key
    end
    
    def self.album_request(deezer_album_id)
        response_string = RestClient.get("https://api.deezer.com/album/#{deezer_album_id}")
        response_hash = JSON.parse(response_string)
    end 

    
end

def album_lines(space)
    dot = " ."
    num = ((77 - space.to_f) / 2)
    # binding.pry
    # if num % 2 == 0 
    #     num.ceil.times {dot += " ."}
    #     dot += " "
    if num % 1 != 0
        num.ceil.times {dot += " ."}
    else
        (num.ceil).times {dot += " ."}
        dot += " "
    end
    dot
end