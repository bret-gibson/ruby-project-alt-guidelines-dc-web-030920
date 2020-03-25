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
    puts "--------------------------"
    valid = nil
    puts "\nENTER SONG NUMBER"
    puts "      OR"
    puts "Enter any other key to go back to main menu"
    puts "\n--------------------------"
    while !valid
        n = gets.chomp
        if n.to_i <= i && n.to_i >0
            valid = true 
        elsif n.to_i > i || n.to_i < 0
            puts "invalid input - try again"
            valid = nil
        elsif n.class == String
            Menu.main_menu(self)
            valid = true
        end
    end
    pick = songs[(n.to_i)-1]
    puts "#{songs[(n.to_i)-1].title} - #{songs[(n.to_i)-1].artist.name}"
    pick
   end

   def search_title
    result = nil
    logo
    puts "---------------------"
    puts "Enter Title to Search"
    puts "---------------------"
    search = gets.chomp
    while !result
        
        result = songs.find {|y| y.title.downcase == search.downcase}
        puts "\nResults:"
        puts "#{result.title} - #{result.artist.name}" if result
        puts "-------------------------"
        if !result
            logo
            puts "------------------------------------------------------"
            puts "Sorry no Song Found" if !result
            puts "Enter a new song or type 'exit' to return to main menu"
            puts "------------------------------------------------------"
            search = gets.chomp
            return result = search if search.downcase == "exit"
            logo
        end
    end
   end

   def search_artist
    puts "Enter Artist to Search"
    search = gets.chomp
    result = songs.select {|y| y.artist.name.downcase == search.downcase}
    result.each {|x| puts "#{x.title} - #{x.artist.name}"}
   end
end
