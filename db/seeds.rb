User.destroy_all
Song.destroy_all
Library.destroy_all
Artist.destroy_all
Album.destroy_all

user1 = User.create(name: "Alex", age: 37, balance: 16.00)
user2 = User.create(name: "Bret", age: 24, balance: 29.00)
user3 = User.create(name: "Little Timmy", age:7, balance: 10.00)
user4 = User.create(name: "Chine", age: 20, balance: 50)

artist1 = Artist.create(name: "Roddy Ricch")
artist2 = Artist.create(name: "Dua Lipa")
artist3 = Artist.create(name: "Future")
artist4 = Artist.create(name: "The Weeknd")
artist5 = Artist.create(name: "Post Malone")
artist6 = Artist.create(name: "Franz Ferdinand")

album2 = Album.create(name: "Please Excuse Me for Being Antisocial", artist_id: artist1.id, deezer_id: 121836132)
album3 = Album.create(name: "Future Nostalgia", artist_id: artist2.id, deezer_id: 137938012)
album4 = Album.create(name: "Life Is Good", artist_id: artist3.id, deezer_id: 125628232)
album5 = Album.create(name: "After Hours", artist_id: artist4.id, deezer_id: 132330332)
album6 = Album.create(name: "Hollywood's Bleeding", artist_id: artist5.id, deezer_id: 110040592)

song1 = Song.create(title: "The Box", artist_id: artist1.id, album_id: album2.id, preview_url: "https://cdns-preview-0.dzcdn.net/stream/c-0f46b78fac27f1c0593f84930fb38988-3.mp3")
song2 = Song.create(title: "Don't Start Now", artist_id: artist2.id, album_id: album3.id, preview_url: "https://cdns-preview-9.dzcdn.net/stream/c-9bb595a44d64e7bdbf1a14fa9b2f8879-3.mp3")
song3 = Song.create(title: "Life Is Good", artist_id: artist3.id, album_id: album4.id, preview_url: "https://cdns-preview-9.dzcdn.net/stream/c-9b72606bdafcd026cfd222a16153750b-3.mp3")
song4 = Song.create(title: "Blinding Lights", artist_id: artist4.id, album_id: album5.id, preview_url: "https://cdns-preview-9.dzcdn.net/stream/c-92e1e84e8071d6ab417a236dc95ab0a9-4.mp3")
song5 = Song.create(title: "Circles", artist_id: artist5.id, album_id: album6.id, preview_url: "https://cdns-preview-d.dzcdn.net/stream/c-df36f056f3f9770ab7b7b466e32975fd-5.mp3")

album1 = Album.create(name: "Always Ascending", artist_id: artist6.id, deezer_id: 49666352)
song6 = Song.create(title: "Always Ascending", artist_id: artist6.id, album_id: album1.id, preview_url: "https://cdns-preview-0.dzcdn.net/stream/c-072981f960236ee1b86b12b01f8c6121-4.mp3")
song7 = Song.create(title: "Lazy Boy", artist_id: artist6.id, album_id: album1.id, preview_url: "https://cdns-preview-d.dzcdn.net/stream/c-d7d33bdb9c45d46313e545cbe022ab1e-3.mp3")
song8 = Song.create(title: "Paper Cages", artist_id: artist6.id, album_id: album1.id, preview_url: "https://cdns-preview-9.dzcdn.net/stream/c-960f25d4f4f0d7852f2a234630732974-3.mp3")
song9 = Song.create(title: "Finally", artist_id: artist6.id, album_id: album1.id, preview_url: "https://cdns-preview-f.dzcdn.net/stream/c-f18802fa6d4f02b28e23d84a720e6525-4.mp3")
song10 = Song.create(title: "The Academy Award", artist_id: artist6.id, album_id: album1.id, preview_url: "https://cdns-preview-b.dzcdn.net/stream/c-b0969b831ca27fb230865c5cc5d21bd5-4.mp3")
song11 = Song.create(title: "Lois Lane", artist_id: artist6.id, album_id: album1.id, preview_url: "https://cdns-preview-b.dzcdn.net/stream/c-b0969b831ca27fb230865c5cc5d21bd5-4.mp3")
song12 = Song.create(title: "Huck and Jim", artist_id: artist6.id, album_id: album1.id, preview_url: "https://cdns-preview-2.dzcdn.net/stream/c-21db799ec7b8bb79dfe2cb639c1fa595-4.mp3")
song13 = Song.create(title: "Glimpse of Love", artist_id: artist6.id, album_id: album1.id, preview_url: "https://cdns-preview-5.dzcdn.net/stream/c-5485d2cef8e26f269dd09e20ec12d576-3.mp3")
song14 = Song.create(title: "Feel the Love Go", artist_id: artist6.id, album_id: album1.id, preview_url: "https://cdns-preview-d.dzcdn.net/stream/c-d18befa71af6f43109de2141e8341d57-3.mp3")
song15 = Song.create(title: "Slow Don't Kill Me Slow", artist_id: artist6.id, album_id: album1.id, preview_url: "https://cdns-preview-4.dzcdn.net/stream/c-403ccdc1021ae389c01d2fa97d5f876d-4.mp3")


library1 = Library.create(song_id: song5.id, user_id: user1.id)
library2 = Library.create(song_id: song3.id, user_id: user1.id)
library3 = Library.create(song_id: song1.id, user_id: user1.id)

library4 = Library.create(song_id: song2.id, user_id: user2.id)
library5 = Library.create(song_id: song3.id, user_id: user2.id)
library6 = Library.create(song_id: song4.id, user_id: user2.id)

library7 = Library.create(song_id: song6.id, user_id: user4.id)
library8 = Library.create(song_id: song7.id, user_id: user4.id)
library9 = Library.create(song_id: song8.id, user_id: user4.id)
library10 = Library.create(song_id: song9.id, user_id: user4.id)
library11 = Library.create(song_id: song10.id, user_id: user4.id)
library12 = Library.create(song_id: song11.id, user_id: user4.id)
library14 = Library.create(song_id: song12.id, user_id: user4.id)
library14 = Library.create(song_id: song14.id, user_id: user4.id)
library15 = Library.create(song_id: song14.id, user_id: user4.id)
library16 = Library.create(song_id: song15.id, user_id: user4.id)