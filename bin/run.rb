require_relative '../config/environment'

def welcome
    puts "Welcome... Please sign-in"
end

def get_user
    input = gets.chomp.upcase
    user = User.all.find {|x| x.name.downcase == input.downcase}
    2.times {puts ""}
    puts "Welcome #{user.name}!"
    2.times {puts ""}
    user
end

def menu(user)
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
                user.add_song
            when 2
                logo
                puts user.display_songs
                2.times {puts ""}
            when 3
                logo
                user.search_artist
                2.times {puts ""}
            when 4
                logo
                user.search_title
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
def logo
    system "clear"
    puts'        888b    888        888       .d8888b.                 888   d8b .d888         
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
    2.times {puts ""}
end

logo
welcome
user = get_user
# binding.pry

menu(user)
puts user.display_songs
# binding.pry
user.search_title
puts "***** END OF PROGRAM ******"