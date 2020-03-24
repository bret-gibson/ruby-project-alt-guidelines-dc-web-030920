
# require 'json'
# require 'pry'
# require 'rest-client'


def web_request
    puts "\nENTER SOMETHING:"
    input = gets.chomp.downcase.gsub(" ", "+")
    response_string = RestClient.get("https://api.deezer.com/search?q=#{input}")
    response_hash = JSON.parse(response_string)
    # ap response_hash
end 

#refactor to make smaller
def add_song_from_search
    result = web_request["data"][0..9]
    # puts result["title"]
    # puts result["artist"]["name"] 
    # puts result["album"]["title"]
    system "clear"
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
    elsif answer == 6
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
        puts "Select a number for song"
        answer = gets.chomp.to_i
        song_result = result[answer -1]["title"]
        artist_result = result[answer -1]["artist"]["name"] 
        album_result = result[answer -1]["album"]["title"]
    else
        puts "ok fine"
    end

    puts "You have selected:"
    puts song_result
    puts artist_result
    puts album_result
    puts "------------------"
    # song_result = result["title"]
    
    # artist_result = result["artist"]["name"]    
    Artist.create(name: artist_result)
    art_id = Artist.all.find {|artist| artist.name.downcase == artist_result.downcase}

    # album_result = result["album"]["title"]
    Album.create(name: album_result, artist_id: art_id.id)
    alb_id = Album.all.find {|album| album.name.downcase == album_result.downcase}

    Song.create(title: song_result, artist_id: art_id.id, album_id: alb_id.id)
end