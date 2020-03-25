class User < ActiveRecord::Base
    has_many :libraries
    has_many :songs, through: :libraries

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
    puts "#{i}. Go back to main menu"
    puts "--------------------------"
    valid = nil
    while !valid
        puts "---- SELECT A SONG -------"
    
        n = gets.chomp.to_i
        valid = true if n <= i && n.class == Integer
    end
        if n == i
            logo
            Menu.main_menu(self)
        end
        #add a validaiton check later
        pick = songs[n-1]
        puts "#{songs[n-1].title} - #{songs[n-1].artist.name}"
    pick
   end

   def search_title
    result = nil
    while !result
        puts "-------------------"
        puts "Enter Title to Search"
        puts "-------------------"
        search = gets.chomp
        result = songs.find {|y| y.title.downcase == search.downcase}
        puts "Results"
        puts "-------------------"
        puts "#{result.title} - #{result.artist.name}" if result
        puts "Sorry no Song Found" if !result
        puts "-------------------"
    end
   end

   def search_artist
    puts "Enter Artist to Search"
    search = gets.chomp
    result = songs.select {|y| y.artist.name.downcase == search.downcase}
    # binding.pry
    result.each {|x| puts "#{x.title} - #{x.artist.name}"}
   end

   def add_song
    #give warning if user has already added song
    logo
    puts "-----------------------------------------"
    puts "Enter a song Title to add to your library"
    puts "-----------------------------------------"
    puts ""
    input = gets.chomp
    add = Song.all.find {|song| song.title.downcase == input.downcase}
    song = Library.create(song_id: add.id, user_id: self.id)
    #add validation check
    puts ""
    puts "#{add.title} by #{add.artist.name} has been added to your library"
    2.times {puts ""}
    reload
   end

#    def add_song_from_api_search(artist_result, album_result, library_result)
#     puts "Add song to library? Y/N"
#     add_song_from_search(self)
#     reply = gets.chomp
#     if reply.downcase == "y"
#         # artist_result = result["artist"]["name"]  

#         #NEED TO CHECK IF ARTIST/SONG/ALBUM ALREADY EXIST BEFORE CREATING

#         Artist.create(name: artist_result) if Artist.all.find {|artist| artist.name.downcase == artist_result.downcase} == nil
#         art_id = Artist.all.find {|artist| artist.name.downcase == artist_result.downcase}

#         # album_result = result["album"]["title"]
#         Album.create(name: album_result, artist_id: art_id.id,deezer_id: deezer_album_id) if Album.all.find {|album| album.name.downcase == album_result.downcase} == nil
#         alb_id = Album.all.find {|album| album.name.downcase == album_result.downcase}

#         Song.create(title: song_result, artist_id: art_id.id, album_id: alb_id.id, preview_url: preview) if Song.all.find {|song| song.title.downcase == song_result.downcase} == nil
#         son_id = Song.all.find{|song| song.title.downcase == song_result.downcase}

#         # add song to database if N to library???
#         if Library.all.find {|lib| lib.user_id == self.id && lib.song_id == son_id.id} == nil
#             Library.create(user_id: self.id, song_id: son_id.id)
#         else
#             puts "\n!!!!!   Song already exists in library    !!!!\n\n"
#         end
#         # elsif reply.downcase == "n"
#         #     web_request
#     else
#         Menu.main_menu(user)
#     end
#    end
end