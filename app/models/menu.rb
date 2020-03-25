class Menu

    @@user = nil
    def self.welcome
        logo
        puts "Welcome... Please sign-in"
        @@user = self.get_user
        main_menu(@@user)
    end

    def self.get_user
       valid = nil
       while (!valid)
            input = gets.chomp.upcase
       
            if User.all.find {|x| x.name.downcase == input.downcase} != nil
                user = User.all.find {|x| x.name.downcase == input.downcase}
                valid = true
            else
                puts "There is no user with this name. Please try again"
                valid = nil
            end
        end
        user
    end

    def self.main_menu(user)
        logo
        menu = true
        while (menu)
            puts  "MAIN MENU"
            puts  "\n#{user.name}, please select a menu item:"
            puts  "-----------------------------------------------"
            puts "1. Search for a song to add to my library"
            puts "2. See all songs in my library"
            puts "3. Search for song in my library by ARTIST"
            puts "4. Search for song in my library by SONG TITLE"
            puts "5. Give me the most popular song among all users"
            puts "6. Logout"
            puts "7. Exit program"
            choice = gets.chomp
            case choice.to_i
                when 1
                    add_song_from_search(@@user)
                when 2
                    logo
                    song_sub_menu(@@user.display_songs)
                    2.times {puts ""}
                when 3
                    logo
                    @@user.search_artist
                    2.times {puts ""}
                when 4
                    logo
                    @@user.search_title
                    2.times {puts ""}
                when 5
                    logo
                    Library.most_added
                when 6
                    Menu.logout
                when 7
                    exit
                when 8
                    binding.pry
            end
       end
    end
    
    def self.song_sub_menu(pick)
        menu = true
        while (menu)
            puts "--------------------------------------------"
            puts "----  YOU HAVE SELECTED: #{pick.title}  ---------"    
            puts "----                                    ---------"    
            puts "----  Select and action for this song   --------" 
            puts "--------------------------------------------"
            # pick = Library.all.find do 
            #     |x| 
            # # binding.pry
            # x.song.title != pick.title
            # end
            # binding.pry
            puts "1. Play song"
            puts "2. Get song album (album name and list of songs in that album)"
            puts "3. See more songs by artist"
            if @@user.songs.all.find {|song| song.title == pick.title}
                puts "4. Remove song from library"
            else
                puts "4. Add song to library" 
            end
            puts "5. Exit to main menu"
            choice = gets.chomp
            case choice.to_i
                when 1
                    logo
                    pick.play_song
                when 2
                    logo
                    Album.show_album_info(pick)
                when 3
                    logo
                    pick.songs_by_artist
                    2.times {puts ""}
                when 4
                    pick.remove_song
                    main_menu(@@user)
                    2.times {puts ""}
                when 5
                    main_menu(@@user)
                when 6
                    binding.pry
            end
       end
     end

     def self.logout
        @@user = nil
        self.welcome
     end
end

def logo
    system "clear"
    puts <<-'EOF'     
        888b    888        888       .d8888b.                 888   d8b .d888         
        8888b   888        888      d88P  Y88b                888   Y8Pd88P"          
        88888b  888        888      Y88b.                     888      888            
        888Y88b 888 .d88b. 888888    "Y888b.  88888b.  .d88b. 888888888888888888  888 
        888 Y88b888d88""88b888          "Y88b.888 "88bd88""88b888   888888   888  888 
        888  Y88888888  888888            "888888  888888  888888   888888   888  888 
        888   Y8888Y88..88PY88b.    Y88b  d88P888 d88PY88..88PY88b. 888888   Y88b 888 
        888    Y888 "Y88P"  "Y888    "Y8888P" 88888P"  "Y88P"  "Y888888888    "Y88888 
                                              888                                 888 
                                              888                            Y8b d88P 
                                              888                             "Y88P"' 
    EOF
2.times {puts ""}
end