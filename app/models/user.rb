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
    puts "---- SELECT A SONG -------"
    n = gets.chomp.to_i
    Menu.main_menu(self) if n == i
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
    # binding.pry
    puts "#{add.title} by #{add.artist.name} has been added to your library"
    2.times {puts ""}
    reload
   end
end