class MusicLibraryController
  attr_accessor :path

  def initialize(path = "./db/mp3s")
    @path = path
    MusicImporter.new(path).import
  end

  def call
    user_input = nil
    while user_input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      user_input = gets.strip

      cli_commonds(user_input)
    end
  end

  def list_songs
    songs = Song.all.sort_by(&:name)
    songs.each_with_index do |song, i|
      puts "#{i + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    artists = Artist.all.sort_by(&:name)
    artists.each_with_index do |artist, i|
      puts "#{i + 1}. #{artist.name}"
    end
  end

  def list_genres
    genres = Genre.all.sort_by(&:name)
    genres.each_with_index do |genre, i|
      puts "#{i + 1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    user_input = gets.strip

    artist = Artist.find_by_name(user_input)
    unless artist.nil?
      artist.songs.sort_by!(&:name)
      artist.songs.each_with_index do |song, i|
        puts "#{i+1}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    user_input = gets.strip

    genre = Genre.find_by_name(user_input)
    unless genre.nil?
      genre.songs.sort_by!(&:name)
      genre.songs.each_with_index do |song, i|
        puts "#{i+1}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    user_input = gets.strip

    if user_input.to_i.between?(1, Song.all.count)
      songs = Song.all.sort_by(&:name)
      user_index = user_input.to_i - 1
      song = songs[user_index]
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end

  def cli_commonds(user_input)
    list_songs if user_input == "list songs"
    list_artists if user_input == "list artists"
    list_genres if user_input == "list genres"
    list_songs_by_artist if user_input == "list artist"
    list_songs_by_genre if user_input == "list genre"
    play_song if user_input == "play song"
  end
end
