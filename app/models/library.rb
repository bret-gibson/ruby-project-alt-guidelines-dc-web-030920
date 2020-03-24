class Library < ActiveRecord::Base
    belongs_to :song
    belongs_to :user

    def self.most_added
        # binding.pry
        id = Library.all.map {|lib| lib.song_id}.group_by(&:itself).max_by {|key, value| value.count}
        most = Song.all.find {|song| song.id == id[0]}
            # binding.pry
        
        logo
        2.times {puts ""}
        puts "--------------------------------"
        puts "--- The Most Popular Song Is ---"
        puts "--------------------------------"
        puts ""
        puts "#{most.title} - #{most.artist}"
        puts "It was added by #{id[1].count} users."
        puts "--------------------------------"
        2.times {puts ""}
        
    end
end