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
    puts "---------------------------------------------"
    n = Menu.selector(i)
    pick = songs[(n.to_i)-1]
    puts "#{songs[(n.to_i)-1].title} - #{songs[(n.to_i)-1].artist.name}"
    logo
    pick
   end
#    def selector(counter)
    
#         valid = nil
#         puts "\nENTER SONG NUMBER"
#         puts "      OR"
#         puts "Enter any other key to go back to main menu"
#         puts "\n-------------------------------------------"
#         while !valid
#             response = gets.chomp
#             if response.to_i <= counter && response.to_i >0
#                 valid = true 
#             elsif response.to_i > counter || response.to_i < 0
#                 puts "invalid input - try again"
#                 valid = nil
#             elsif response.class == String
#                 Menu.main_menu(self)
#                 valid = true
#             end
#         end
#         response
#     end

   def search_title
    result = nil
    logo
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
    n = Menu.selector(i)
    pick = result[(n.to_i)-1]
    puts "#{result[(n.to_i)-1].title} - #{result[(n.to_i)-1].artist.name}"
    logo
    pick
   end

   def search_artist
    puts "Enter Artist to Search"
    search = gets.chomp.titleize
    artist_result = Artist.where(name: search)[0]
    # binding.pry
    song_results = Song.where(artist_id: artist_result.id)
    # binding.pry
    i = 0
    puts "-----------------------------------"
    song_results.each {|song| puts "#{i+=1}. #{song.title} - #{artist_result.name}"}
    n = Menu.selector(i)
    pick = song_results[(n.to_i)-1]
    puts "#{song_results[(n.to_i)-1].title} - #{song_results[(n.to_i)-1].artist.name}"
    logo
    pick
   end
end
