
# require 'json'
# require 'pry'
# require 'rest-client'


def search_request
    puts "\nPlease search for a song:"
    input = gets.chomp.downcase.gsub(" ", "+")
    response_string = RestClient.get("https://api.deezer.com/search?q=#{input}")
    response_hash = JSON.parse(response_string)
end 

def album_request(input)
    # puts "\nPlease search for a song:"
    response_string = RestClient.get("https://api.deezer.com/album/#{input}")
    response_hash = JSON.parse(response_string)
end 

#refactor to make smaller
# FIX TO MAKE WORK WHEN NO RESULTS/TYPO
# FIX TO MAKE WORK WHEN THERE ARE LESS THAN FIVE RESULTS
def add_song_from_search(user)
    
    result = search_request["data"][0..9]
    system "clear"
    # binding.pry
    i = 1
    result[0..4].each do |song_data|
        puts "--------------------------------------------"
            puts ""
            puts "        Song: #{song_data["title"]}"
            puts "  #{i}.    Artist: #{song_data["artist"]["name"]}" 
            puts "        Album: #{song_data["album"]["title"]}"
            puts "--------------------------------------------"
        i+=1
    end
    puts "Select number for song or hit 6 for next 5 songs"
    answer = gets.chomp.to_i
    if answer <= 5
        song_result = result[answer -1]["title"]
        artist_result = result[answer -1]["artist"]["name"] 
        album_result = result[answer -1]["album"]["title"]
        deezer_album_id = result[answer -1]["album"]["id"]
    elsif answer == 6 && search_request["data"].count >= 5
        system "clear"
        result[5..9].each do |song_data|
            puts "--------------------------------------------"
            puts ""
            puts "        Song: #{song_data["title"]}"
            if i > 9
                puts "  #{i}.   Artist: #{song_data["artist"]["name"]}" 
            else
                puts "  #{i}.    Artist: #{song_data["artist"]["name"]}" 
            end
            puts "        Album: #{song_data["album"]["title"]}"
            puts "--------------------------------------------"
            i+=1
        end

        puts "Select a number for song or EXIT to exit"
        answer = gets.chomp
        exit if answer.downcase == "exit"
        answer = answer.to_i
        song_result = result[answer -1]["title"]
        artist_result = result[answer -1]["artist"]["name"] 
        album_result = result[answer -1]["album"]["title"]
        deezer_album_id = result[answer -1]["album"]["id"]
    end
    
    logo
    puts "You have selected:"
    puts song_result
    puts artist_result
    puts album_result
    puts "------------------"
    # song_result = result["title"]
    puts "Add song to library? Y/N"
    reply = gets.chomp
    if reply.downcase == "y"
        # artist_result = result["artist"]["name"]  

        #NEED TO CHECK IF ARTIST/SONG/ALBUM ALREADY EXIST BEFORE CREATING

        Artist.create(name: artist_result) if Artist.all.find {|artist| artist.name.downcase == artist_result.downcase} == nil
        art_id = Artist.all.find {|artist| artist.name.downcase == artist_result.downcase}

        # album_result = result["album"]["title"]
        Album.create(name: album_result, artist_id: art_id.id,deezer_id: deezer_album_id) if Album.all.find {|album| album.name.downcase == album_result.downcase} == nil
        alb_id = Album.all.find {|album| album.name.downcase == album_result.downcase}

        Song.create(title: song_result, artist_id: art_id.id, album_id: alb_id.id) if Song.all.find {|song| song.title.downcase == song_result.downcase} == nil
        son_id = Song.all.find{|song| song.title.downcase == song_result.downcase}

        # add song to database if N to library???
        if Library.all.find {|lib| lib.user_id == user.id && lib.song_id == son_id.id} == nil
            Library.create(user_id: user.id, song_id: son_id.id)
        else
            puts "\n!!!!!   Song already exists in library    !!!!\n\n"
        end
        # elsif reply.downcase == "n"
        #     web_request
    else
        Menu.main_menu(user)
    end
end