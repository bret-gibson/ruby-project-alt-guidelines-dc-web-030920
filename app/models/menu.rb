class Menu

    @@user = nil
    def self.welcome
        logo
        puts "Welcome... Please sign-in"
        @@user = self.get_user
        main_menu(@@user)
    end

    def self.get_user
        input = gets.chomp.upcase
        get = User.all.find {|x| x.name.downcase == input.downcase}
        2.times {puts ""}
        puts "Welcome #{get.name}!"
        2.times {puts ""}
        get
    end

    def self.main_menu(user)
        menu = true
        while (menu)
    # I can add a song to my library
    # I can see all the songs in my library
    # I can search for songs in my library by artist
    # I can search for songs in my library by title
    # I can get the number of users who have added the song to their library (how popular the song is)
    # I can find the most popular song
            puts "Please select a menu item:"
            puts "1. Add song to library"
            puts "2. See all songs in my library"
            puts "3. Search for song in my library by ARTIST"
            puts "4. Search for song in my library by SONG TITLE"
            puts "5. Give me the most popular song among all users"
            puts "6. Exit"
            choice = gets.chomp
            case choice.to_i
                when 1
                    @@user.add_song
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
                exit
                when 7
                    binding.pry
            end
       end
    end
    
    def self.song_sub_menu(pick)
        menu = true
        while (menu)
            puts "--------------------------------------------"
            puts "----  YOU HAVE SELECTED: #{pick.title}  ---------"    
            puts "----  SELECT AN ACTION FOR THIS SONG   -------" 
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
                    puts "song is playing"
                when 2
                    puts "album information"
                    2.times {puts ""}
                when 3
                    pick.songs_by_artist
                    2.times {puts ""}
                when 4
                    # if @@user.songs.all.find {|song| song.title == pick.song.title}
                    #     puts "remove song from library"
                        pick.remove_song
                        main_menu(@@user)
                    # else
                    #     pick.song.add_song(@@user)
                    # end
                    2.times {puts ""}
                when 5
                    main_menu(@@user)
                when 6
                    binding.pry
            end
       end
     end

 
end

