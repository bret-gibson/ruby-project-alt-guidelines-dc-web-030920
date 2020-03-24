User.destroy_all
Song.destroy_all
Library.destroy_all
Artist.destroy_all
Album.destroy_all

user1 = User.create(name: "Alex")
user2 = User.create(name: "Bret")

artist1 = Artist.create(name: "Roddy Ricch")
artist2 = Artist.create(name: "Dua Lipa")
artist3 = Artist.create(name: "Future")
artist4 = Artist.create(name: "The Weeknd")
artist5 = Artist.create(name: "Post Malone")
artist6 = Artist.create(name: "Franz Ferdinand")

song1 = Song.create(title: "The Box", artist_id: artist1.id)
song2 = Song.create(title: "Don't Start Now", artist_id: artist2.id)
song3 = Song.create(title: "Life is Good", artist_id: artist3.id)
song4 = Song.create(title: "Blinding Lights", artist_id: artist4.id)
song5 = Song.create(title: "Circles", artist_id: artist5.id)

album1 = Album.create(name: "Always Ascending", artist_id: artist6.id)
song6 = Song.create(title: "Always Ascending", artist_id: artist6.id, album_id: album1.id)
song7 = Song.create(title: "Lazy Boy", artist_id: artist6.id, album_id: album1.id)
song8 = Song.create(title: "Paper Cages", artist_id: artist6.id, album_id: album1.id)
song9 = Song.create(title: "Finally", artist_id: artist6.id, album_id: album1.id)
song10 = Song.create(title: "The Academy Award", artist_id: artist6.id, album_id: album1.id)
song11 = Song.create(title: "Lois Lane", artist_id: artist6.id, album_id: album1.id)
song12 = Song.create(title: "Huck and Jim", artist_id: artist6.id, album_id: album1.id)
song13 = Song.create(title: "Glimpse of Love", artist_id: artist6.id, album_id: album1.id)
song14 = Song.create(title: "Feel the Love Go", artist_id: artist6.id, album_id: album1.id)
song15 = Song.create(title: "Slow Don't Kill Me Slow", artist_id: artist6.id, album_id: album1.id)



library1 = Library.create(song_id: song5.id, user_id: user1.id)
library2 = Library.create(song_id: song3.id, user_id: user1.id)
library3 = Library.create(song_id: song1.id, user_id: user1.id)

library4 = Library.create(song_id: song2.id, user_id: user2.id)
library5 = Library.create(song_id: song3.id, user_id: user2.id)
library6 = Library.create(song_id: song4.id, user_id: user2.id)

