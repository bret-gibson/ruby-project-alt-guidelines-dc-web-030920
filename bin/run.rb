require_relative '../config/environment'

def welcome
    puts "Welcome... Please sign-in"
end

def get_user
    input = gets.chomp
    User.all.find {|x| x.name == input}
end

# def menu
#     menu = true
#     while (menu)
# I can add a song to my library
# I can see all the songs in my library
# I can search for songs in my library by artist
# I can search for songs in my library by title
# I can get the number of users who have added the song to their library (how popular the song is)
# I can find the most popular song
        # puts "Please select a menu item:"
        # puts "1. Add song to library"
        # puts "2. See all songs in my library"
        # puts "3. Search for song in my library by ARTIST"
        # puts "4. Search for song in my library by SONG TITLE"
        # puts "5. Give me the most popular song among all users"
        # puts "6. Exit"
        #choice = gets
        #case choice
        # when 1
        # puts "selected 1"
        # when 2
        # puts "selected 2"
        # when 3
        # puts "selected 3"
        # when 4
        # puts "selected 4"
        # when 5
        # puts "selected 5"
        # when 6
        # puts "selected 6"
#    end
# end

welcome
user = get_user
# binding.pry
puts "hi #{user.name}"

# puts user.songs.map {|x| x.title}
# binding.pry
puts "***** END OF PROGRAM ******"