class Library < ActiveRecord::Base
    belongs_to :song
    belongs_to :user

    def self.most_added
        id = Library.all.map {|lib| lib.song_id}.group_by(&:itself).max_by {|key, value| value.count}
        most = Song.all.find {|song| song.id == id[0]}
        Menu.logo
        puts " -------------------------------------\n".green
        puts ""
        puts " ***".light_cyan + "  The Most Popular Song Is...  " + "***".light_cyan
        puts ""
        puts "  #{most.title} - #{most.artist.name}"
        puts "  It was added by " + "#{id[1].count}".light_green + " users."
        puts "\n -------------------------------------".green
        2.times {puts ""}
        puts " Press ENTER to continue"
        gets.chomp
        Menu.logo
    end
end