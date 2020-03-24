class User < ActiveRecord::Base
    has_many :libraries
    has_many :songs, through: :libraries

   def display_songs
    puts "--------------------------"
    puts "Song Title --- Artist Name"
    puts "--------------------------"
    i = 1
    songs.each do |x| 
        puts "#{i}. #{x.title} - #{x.artist}" 
        i+=1
    end
    puts "--------------------------"
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
        puts "#{result.title} - #{result.artist}" if result
        puts "Sorry no Song Found" if !result
        puts "-------------------"
    end
   end

   def search_artist
    puts "Enter Artist to Search"
    search = gets.chomp
    result = songs.select {|y| y.artist.downcase == search.downcase}
    # binding.pry
    result.each {|x| puts "#{x.title} - #{x.artist}"}
   end
end