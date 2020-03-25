
# require 'json'
# require 'pry'
# require 'rest-client'


def search_request
    puts "\nPlease search for a song:"
    input = gets.chomp.downcase.gsub(" ", "+")
    response_string = RestClient.get("https://api.deezer.com/search?q=#{input}")
    response_hash = JSON.parse(response_string)
end 

def album_request(deezer_album_id)
    # puts "\nPlease search for a song:"
    response_string = RestClient.get("https://api.deezer.com/album/#{deezer_album_id}")
    response_hash = JSON.parse(response_string)
end 


def search_results
    search_results = {}
    search = search_request["data"][0..9]
    system "clear"
    full_song_hash = choose_search_results(search)

    search_results[:song] =  full_song_hash["title"]
    search_results[:artist] = full_song_hash["artist"]["name"] 
    search_results[:album] = full_song_hash["album"]["title"]
    search_results[:deezer_id] = full_song_hash["album"]["id"]
    search_results[:preview_link] = full_song_hash["preview"]
    search_results
end


# FIX TO MAKE WORK WHEN NO RESULTS/TYPO
# FIX TO MAKE WORK WHEN THERE ARE LESS THAN FIVE RESULTS
def add_song_from_search(user)
    choice_data = search_results
    puts "You have selected:"
    puts "Song: #{choice_data[:song]}"
    puts "Artist: #{choice_data[:artist]}"
    puts "Album: #{choice_data[:album]}"
    puts "------------------"
    add_search_to_library(choice_data, user)
end



def add_search_to_library(data, user)
    puts "Add song to library? Y/N"
    reply = gets.chomp
    if user.age < 18 && data["explicit_lyrics"]
        puts "Minors are not allowed to add songs with explicit content"
    elsif reply.downcase == "y"
        Artist.create(name: data[:artist]) if Artist.all.find {|artist| artist.name.downcase == data[:artist].downcase} == nil
        art_id = Artist.all.find {|artist| artist.name.downcase == data[:artist].downcase}

        # album_result = data["album"]["title"]
        Album.create(name: data[:album], artist_id: art_id.id, deezer_id: data[:deezer_id]) if Album.all.find {|album| album.name.downcase == data[:album].downcase} == nil
        alb_id = Album.all.find {|album| album.name.downcase == data[:album].downcase}

        Song.create(title: data[:song], artist_id: art_id.id, album_id: alb_id.id, preview_url: data[:preview_link]) if Song.all.find {|song| song.title.downcase == data[:song].downcase} == nil
        son_id = Song.all.find{|song| song.title.downcase == data[:song].downcase}

        # add song to database if N to library???
        if Library.all.find {|lib| lib.user_id == user.id && lib.song_id == son_id.id} == nil
            Library.create(user_id: user.id, song_id: son_id.id)
        else
            puts "\n!!!!!   Song already exists in library    !!!!\n\n"
        end
        # elsif reply.downcase == "n"
        #     web_request
    else
        puts "#{data[:song]} has been added to your library! \n\n"
        Menu.main_menu(user)
    end
end

def choose_search_results(result)
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
        preview = result[answer -1]["preview"]
    elsif answer == 6 
    # && search_request["data"].size >= 5
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
        result[answer-1]
    end
    result[answer-1]
end