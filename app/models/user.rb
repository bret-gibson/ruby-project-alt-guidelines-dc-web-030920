class User < ActiveRecord::Base
    has_many :libraries
    has_many :songs, through: :libraries
    @@user = nil
    
    def self.welcome
        Menu.logo
        puts "Welcome... Please sign-in\n\n"
        @@user = self.get_user
        Menu.main_menu(@@user)
    end

    def self.get_user
    valid = nil
    
        while !valid
            input = gets.chomp.titleize
            if User.where(name: input.titleize)[0] != nil
                user = User.where(name: input.titleize)[0]
                valid = true
            else
                puts "There is no user with this name. Please try again"
                valid = nil
            end
        end
        user
    end

    def display_songs
        reload
        puts "--------------------------"
        puts "Song Title --- Artist Name"
        puts "--------------------------"
        i = 1
        songs.each do |song| 
            puts "#{i}. #{song.title} - #{song.artist.name}" 
            i+=1
        end
        puts "---------------------------------------------"
        n = Menu.selector(i)
        pick = songs[(n.to_i)-1]
        puts "#{songs[(n.to_i)-1].title} - #{songs[(n.to_i)-1].artist.name}"
        Menu.logo
        pick
    end

    def search_title
        result = nil
        Menu.logo
        puts "---------------------"
        puts "Enter Title to Search"
        puts "---------------------"
        search = gets.chomp.titleize
        while !result
            result = Song.where(title: search)
            puts "\nResults:"
            i=0
            result.each do |song|
                puts "#{i+=1}. #{song.title} - #{song.artist.name}" if result
            end
            puts "-------------------------"
            if result == []
                Menu.logo
                puts "------------------------------------------------------"
                puts "Sorry no Song Found" if result == []
                puts "Type a new song or hit 'Enter' to return to main menu"
                puts "------------------------------------------------------"
                search = gets.chomp.titleize
                if search == ""
                    Menu.main_menu(self)
                else
                    Menu.logo
                    result=nil
                end
            end
        end
        n = Menu.selector(i)
        pick = result[(n.to_i)-1]
        puts "#{result[(n.to_i)-1].title} - #{result[(n.to_i)-1].artist.name}"
        Menu.logo
        pick
    end

    def search_artist
        puts "Enter Artist to Search"
        valid = nil
        while !valid
            search = gets.chomp.titleize
                if !Artist.where(name: search)[0] && search != ""
                    Menu.logo
                    puts "No artist found! Enter a new search:"
                    puts "Or, press 'Enter' to exit"
                elsif search == ""
                    Menu.main_menu(self)
                else    
                    valid = true
                end
        end

        artist_result = Artist.where(name: search)[0]
        song_results = Song.where(artist_id: artist_result.id)
        i = 0
        puts "-----------------------------------"
        song_results.each {|song| puts "#{i+=1}. #{song.title} - #{artist_result.name}"}
        n = Menu.selector(i)
        pick = song_results[(n.to_i)-1]
        puts "#{song_results[(n.to_i)-1].title} - #{song_results[(n.to_i)-1].artist.name}"
        Menu.logo
        pick
    end
    
    def add_song_from_search
        Menu.logo
        choice_data = get_single_song_data_from_search
        Menu.logo
        display_selection(choice_data)
        add_selection_to_library(choice_data)
    end
    
    def get_single_song_data_from_search
        song_data = {}
        search_results = search_request["data"]
        system "clear"
        full_song_hash = choose_search_result(search_results)
    
        song_data[:song] =  full_song_hash["title"]
        song_data[:artist] = full_song_hash["artist"]["name"] 
        song_data[:album] = full_song_hash["album"]["title"]
        song_data[:deezer_id] = full_song_hash["album"]["id"]
        song_data[:preview_link] = full_song_hash["preview"]
        song_data[:explicit] = full_song_hash["explicit_lyrics"]
        song_data
    end
    
    def search_request
        valid = nil
        Menu.logo
        puts "\nPlease search for a song:"
        while !valid
            input = gets.chomp.downcase.gsub(" ", "+")
            response_string = RestClient.get("https://api.deezer.com/search?q=#{input}")
            response_hash = JSON.parse(response_string)
            if response_hash["data"] == []
                Menu.logo
                puts "\nNo results found, please type a new search or Press ENTER to go back"
            elsif input == ""
                Menu.main_menu
            else
                valid = true 
            end
        end
        response_hash
    end 
    
    def choose_search_result(result)
        i = 1
        Menu.logo
        puts "TOTAL RESULTS: #{result.count}"
        result.each_with_index do |song_data, index|
            
            puts "--------------------------------------------"
            puts ""
            puts "        Song: #{song_data["title"]}"
            puts "  #{i}.    Artist: #{song_data["artist"]["name"]}" 
            puts "        Album: #{song_data["album"]["title"]}"
            puts ""
            puts "--------------------------------------------"
            i+=1
            
            if (index + 1) % 5 == 0 && (index + 1) != result.count
                puts "Select number for song or hit N for next 5 songs" 
                puts "Hit Enter to exit" 
                answer = gets.chomp
                if answer.to_i <= (index + 1) && answer.to_i > 0
                    return result[(answer.to_i) -1]
                elsif answer.downcase != "n" && answer.downcase == ""
                    Menu.main_menu(self)
                else
                    Menu.logo
                end
            elsif (index + 1) == result.count
                puts "-------   END OF SEARCH RESULTS   --------"
                puts "\nSelect number for song"
                puts "Enter any key to exit"
                answer = gets.chomp
                if answer.to_i <= (index + 1) && answer.to_i > 0
                    return result[(answer.to_i) -1]
                else
                    Menu.main_menu(self)
                end
            end
        end
        result[answer-1]
    end
    
    def display_selection(selection_data)
        puts "You have selected:"
        # puts Menu.create_separator(longest)
        puts "----------------------------"
        puts "Song: #{selection_data[:song]}"
        puts "Artist: #{selection_data[:artist]}"
        puts "Album: #{selection_data[:album]}"
        puts "----------------------------"
        # puts Menu.create_separator(longest)
        # puts "\n"
    end
    
    def add_selection_to_library(data)
        puts "Add song to library? Y/N"
        reply = gets.chomp
        Menu.logo
        if self.age < 18 && data[:explicit]
            puts "Minors are not allowed to add songs with explicit content".red
        elsif reply.downcase == "y"
            
            artist = Artist.where(name: data[:artist])[0]
            if artist == nil
                artist = Artist.create(name: data[:artist]) 
            end
            album = Album.where(name: data[:album])[0]
            if album == nil
                album = Album.create(name: data[:album], artist_id: artist.id, deezer_id: data[:deezer_id]) 
            end
            song = Song.where(title: data[:song], artist_id: artist.id)[0]
            if song == nil
                song = Song.create(title: data[:song], artist_id: artist.id, album_id: album.id, preview_url: data[:preview_link]) 
            end
            if Library.all.find {|lib| lib.user_id == self.id && lib.song_id == song.id} == nil
                Library.create(user_id: self.id, song_id: song.id)
                self.balance -= 1.00
                binding.pry
                
              
                Menu.logo
                puts "\n#{data[:song]} by #{data[:artist]} has been added to your library! \n\n"
                puts "\n Press 'ENTER' to return to Main Menu"
                gets.chomp
                Menu.main_menu(self)
            else
                Menu.logo
                puts "\n!!!!!   Song already exists in library    !!!!\n\n"
                puts "\n Press 'ENTER' to return to Main Menu"
                gets.chomp
                Menu.main_menu(self)
            end

        else
            Menu.main_menu(self)
        end
    end
end
