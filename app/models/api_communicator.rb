
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
    response_string = RestClient.get("https://api.deezer.com/album/#{deezer_album_id}")
    response_hash = JSON.parse(response_string)
end 

def get_single_song_data_from_search(user)
    song_data = {}
    first_ten_search_results = search_request["data"][0..9]
    system "clear"
    full_song_hash = choose_search_result(first_ten_search_results, user)

    song_data[:song] =  full_song_hash["title"]
    song_data[:artist] = full_song_hash["artist"]["name"] 
    song_data[:album] = full_song_hash["album"]["title"]
    song_data[:deezer_id] = full_song_hash["album"]["id"]
    song_data[:preview_link] = full_song_hash["preview"]
    song_data
end

def display_selection(selection_data)
    puts "You have selected:\n\n"
    puts "Song: #{selection_data[:song]}"
    puts "Artist: #{selection_data[:artist]}"
    puts "Album: #{selection_data[:album]}"
    puts "------------------"
end

# FIX TO MAKE WORK WHEN NO RESULTS/TYPO
# FIX TO MAKE WORK WHEN THERE ARE LESS THAN FIVE RESULTS
def add_song_from_search(user)
    logo
    choice_data = get_single_song_data_from_search(user)
    logo
    display_selection(choice_data)
    add_selection_to_library(choice_data, user)
end

def add_selection_to_library(data, user)
    puts "Add song to library? Y/N"
    reply = gets.chomp
    logo
    if user.age < 18 && data["explicit_lyrics"]
        puts "Minors are not allowed to add songs with explicit content"
    elsif reply.downcase == "y"
        artist = Artist.all.find {|artist| artist.name.downcase == data[:artist].downcase}
        if artist == nil
            artist = Artist.create(name: data[:artist]) 
        end
        album = Album.all.find {|album| album.name.downcase == data[:album].downcase}
        if album == nil
            album = Album.create(name: data[:album], artist_id: artist.id, deezer_id: data[:deezer_id]) 
        end
        song = Song.all.find {|song| song.title.downcase == data[:song].downcase && song.artist.name == data[:artist]}
        if song == nil
            song = Song.create(title: data[:song], artist_id: artist.id, album_id: album.id, preview_url: data[:preview_link]) 
        end
        if Library.all.find {|lib| lib.user_id == user.id && lib.song_id == song.id} == nil
            Library.create(user_id: user.id, song_id: song.id)
            logo
            puts "\n#{data[:song]} by #{data[:artist]} has been added to your library! \n\n"
            puts "\n Press 'ENTER' to return to Main Menu"
            gets.chomp
            Menu.main_menu(user)
        else
            logo
            puts "\n!!!!!   Song already exists in library    !!!!\n\n"
            puts "\n Press 'ENTER' to return to Main Menu"
            gets.chomp
            Menu.main_menu(user)
        end
    else
        Menu.main_menu(user)
    end
end

def choose_search_result(result, user)
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
    elsif answer == 6 && result.count >= 5
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
        Menu.main_menu(user) if answer.downcase == "exit"
        answer = answer.to_i
        result[answer-1]
    end
    result[answer-1]
end