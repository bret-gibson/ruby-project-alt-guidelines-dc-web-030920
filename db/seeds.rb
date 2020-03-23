User.destroy_all
Song.destroy_all
Library.destroy_all

user1 = User.create(name: "Alex")
user2 = User.create(name: "Brett")

song1 = Song.create(title: "The Box", artist: "Roddy Ricch")
song2 = Song.create(title: "Don't Start Now", artist: "Dua Lipa")
song3 = Song.create(title: "Life is Good", artist: "Future")
song4 = Song.create(title: "Blinding Lights", artist: "The Weeknd")
song5 = Song.create(title: "Circles", artist: "Post Malone")

library1 = Library.create(song_id: song5.id, user_id: user1.id)
library2 = Library.create(song_id: song3.id, user_id: user1.id)
library3 = Library.create(song_id: song1.id, user_id: user1.id)

library4 = Library.create(song_id: song2.id, user_id: user2.id)
library5 = Library.create(song_id: song3.id, user_id: user2.id)
library6 = Library.create(song_id: song4.id, user_id: user2.id)