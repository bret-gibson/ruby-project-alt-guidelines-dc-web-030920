class Menu

    @@user = nil

    def self.main_menu(user)
        @@user = user
        logo
        menu = true
        while (menu)
            puts  "MAIN MENU"
            puts  "\n#{user.name}, please select a menu item:"
            puts  "-----------------------------------------------"
            puts "1. Search for a song to add to my library"
            puts "2. See all songs in my library"
            puts "3. Search for songs in my library by ARTIST"
            puts "4. Search for songs in my library by SONG TITLE"
            puts "5. Give me the most popular song among all users"
            puts "6. Logout"
            puts "7. Exit program"
            choice = gets.chomp
            case choice.to_i
                when 1
                    user.add_song_from_search
                when 2
                    logo
                    song_sub_menu(user.display_songs)
                    2.times {puts ""}
                when 3
                    logo
                    song_sub_menu(user.search_artist)
                    2.times {puts ""}
                when 4
                    logo
                    song_sub_menu(user.search_title)
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
            if pick.class != Hash  
                selected_text = "  You have selected: #{pick.title} by #{pick.artist.name}" 
            else 
                selected_text = "  You have selected: #{pick[:song]} by #{pick[:artist].name}"
            end
            
            puts self.create_separator(selected_text)
            puts "\n#{selected_text}\n\n" 
            # puts self.create_separator(selected_text)
            puts "\n  Select an action for this song:\n\n" 
            puts create_separator(selected_text)
       
            puts "1. Play song"
            puts "2. Get song album (album name and list of songs in that album)"
            puts "3. See more songs in library by artist"
            if pick.class != Hash && @@user.songs.all.find {|song| song.title == pick.title} 
                puts "4. Remove song from library"
            elsif pick.class == Hash && @@user.songs.all.find{|song| song.title == pick[:song]}
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
                    pick.songs_by_artist if pick.class != Hash
                    if pick.class == Hash
                        pick = Song.where(artist_id: pick[:artist].id)[0]
                        pick.songs_by_artist
                    end
                    
                    2.times {puts ""}
                when 4
                    if pick.class == Hash
                        new_song = Song.create(title: pick[:song], artist_id: pick[:artist].id, album_id: pick[:album].id, preview_url: pick[:preview])
                        Library.create(song_id: new_song.id, user_id: @@user.id )
                    else
                        pick.remove_song
                    end
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
        User.welcome
    end

    def self.selector(counter)
        valid = nil
        puts "-------------------------------------------"
        puts "\nENTER SONG NUMBER"
        puts "      OR"
        puts "Enter any other key to go back to main menu"
        puts "\n-------------------------------------------"
        while !valid
            response = gets.chomp
            if response.to_i <= counter && response.to_i >0
                valid = true 
            elsif response.to_i > counter || response.to_i < 0
                puts "invalid input - try again"
                valid = nil
            elsif response.class == String
                Menu.main_menu(@@user)
                valid = true
            end
        end
        response
    end

    def self.go_back_with_any_key
         puts "Enter any key to go back"
         gets.chomp
         logo
    end

    def self.create_separator(text)
        line = ""
        text.length.times {line += "-"}
        line
    end

end

def logo
    system "clear"
    2.times {puts ""}
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
