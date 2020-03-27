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
        longest = songs.map {|x| x.title.length + x.artist.name.length}
        length = longest.max.to_i
        
        puts " "+line_art(length).green+"------".green
        puts " Song Title --- Artist Name"
        puts " "+line_art(length).green+"------".green
        i = 1

        songs.each do |song| 
            puts " #{i}.  #{song.title} - #{song.artist.name}" if i <= 9 
            puts " #{i}. #{song.title} - #{song.artist.name}" if i >= 10 
            i+=1
        end

        puts " "+line_art(length).green+"------".green
        n = Menu.selector(i)
        pick = songs[(n.to_i)-1]
        puts "#{songs[(n.to_i)-1].title} - #{songs[(n.to_i)-1].artist.name}"
        Menu.logo
        pick
    end

    def search_title
        result = nil
        Menu.logo
        puts "---------------------\n".green
        puts "Enter Title to Search\n\n"
        puts "---------------------".green
        search = gets.chomp.titleize
        while !result
            Menu.logo
            result = Song.where(title: search)
            puts "--------------------------------------------\n".green
            puts "\nResults:"
            i=0
            result.each do |song|
                puts "#{i+=1}. #{song.title} - #{song.artist.name}\n" if result
            end
            puts "--------------------------------------------".green
            if result == []
                Menu.logo
                puts "------------------------------------------------------".light_red
                puts "Sorry no song Found!" if result == []
                puts "Type a new song or hit 'Enter' to return to main menu"
                puts "------------------------------------------------------".light_red
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
        puts "----------------------\n".green
        puts "Enter Artist to Search\n\n"
        puts "----------------------".green
        valid = nil
            search = gets.chomp.titleize
        while !valid
                if Artist.where(name: search) == []
                    Menu.logo
                    puts "------------------------------------------------------".light_red
                    puts "Sorry no artist found!"
                    puts "Type a new artist or hit 'Enter' to return to main menu"
                    puts "------------------------------------------------------".light_red
                    search = gets.chomp.titleize
                    if search == ""
                        Menu.main_menu(self)
                    else    
                        valid = nil
                        Menu.logo
                    end
                elsif Artist.where(name: search) != []
                    valid = true
                    Menu.logo
                end
        end

        artist_result = Artist.where(name: search)[0]
        song_results = Song.where(artist_id: artist_result.id)
        i = 0
        puts "--------------------------------------------".green
        puts "\n Songs by #{artist_result.name}:\n"
        song_results.each {|song| puts " \n #{i+=1}. #{song.title}"}
        puts "\n --------------------------------------------".green
        n = Menu.selector(i)
        pick = song_results[(n.to_i)-1]
        puts " #{song_results[(n.to_i)-1].title} - #{song_results[(n.to_i)-1].artist.name}"
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
                Menu.main_menu(self)
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
            
            puts "-----------------------------------------------".green
            puts ""
            puts "        Song: #{song_data["title"]}"
            puts "  #{i}.    Artist: #{song_data["artist"]["name"]}" if i <=9
            puts "  #{i}.   Artist: #{song_data["artist"]["name"]}" if i >=10
            puts "        Album: #{song_data["album"]["title"]}"
            puts ""
            puts "-----------------------------------------------".green
            i+=1
            
            if (index + 1) % 5 == 0 && (index + 1) != result.count
                puts "Please enter a song number or hit N for next 5 songs" 
               # (#{((index+2) -5)} - #{(index + 1)})
                puts "Hit 'Enter' to exit" 
                answer = gets.chomp
                if answer.to_i <= (index + 1) && answer.to_i > 0
                    return result[(answer.to_i) -1]
                elsif answer.downcase != "n" && answer.downcase == ""
                    Menu.main_menu(self)
                else
                    Menu.logo
                end
            elsif (index + 1) == result.count
                puts "-------------".green + " END OF SEARCH RESULTS ".light_blue  + "-----------".green
                puts "\nPlease enter a song number"
               # (#{index} - #{result.count})
                puts "Or, enter any other key to exit"
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
        line_arr = ["Song: #{selection_data[:song]}", "Artist: #{selection_data[:artist]}",
        "Album: #{selection_data[:album]}"]
        longest_line = line_arr.max_by(&:length)
        puts " You have selected:\n\n"
        puts " "+Menu.create_separator(longest_line)
        puts "\n Song: #{selection_data[:song]}"
        puts " Artist: #{selection_data[:artist]}"
        puts " Album: #{selection_data[:album]}\n\n"
        puts " "+Menu.create_separator(longest_line)
    end
    
    def add_selection_to_library(data)
        puts " Add song to library? Y/N"
        reply = gets.chomp
        Menu.logo
        if self.age < 18 && data[:explicit]
            puts " Minors are not allowed to add songs with explicit content".light_red
            puts " press Enter to continue"
            gets.chomp
            Menu.logo
        elsif reply.downcase == "y"
            if self.balance <= 0.00
                puts " Cannot add song: Balance is $0.00".light_red
                puts " Press enter to continue"
                gets.chomp
                Menu.logo
            else
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
                    self.save                    
                    Menu.logo
                    puts "\n#{data[:song]} by #{data[:artist]} has been" + " added ".green + "to your library! \n\n"
                    puts "\nPress 'ENTER' to return to Main Menu"
                    gets.chomp
                    Menu.main_menu(self)
                else
                    Menu.logo
                    puts "\n!!!!!   Song already exists in library    !!!!\n\n"
                    puts "\n     Press 'ENTER' to return to Main Menu"
                    gets.chomp
                    Menu.main_menu(self)
                end
            end
        else
            Menu.main_menu(self)
        end
    end

    def line_art(size)
        l = ""
        size.times {l += "-"}
        l
    end
end
