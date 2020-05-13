class MusicLibraryController
  attr_accessor :path, :lib

  def initialize(path = "./db/mp3s")
    @path = path
    @lib = MusicImporter.new(path).import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = gets.chomp

    until input == "exit"
      case input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      end
      input = gets.chomp
    end
  end

  def list_songs
    sorted = sort_class(Song.all)
    sorted.each_with_index { |song, i| puts "#{i + 1}. #{song.to_string}" }
  end

  def list_artists
    sorted = sort_class(Artist.all)
    sorted.each_with_index { |artist, i| puts "#{i + 1}. #{artist.name}" }
  end

  def list_genres
    sorted = sort_class(Genre.all)
    sorted.each_with_index { |genre, i| puts "#{i + 1}. #{genre.name}" }
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist = Artist.find_by_name(gets.chomp)
    return if artist.nil?

    sort_class(artist.songs).each_with_index do |song, i|
      puts "#{i + 1}. #{song.to_string(:genre)}"
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre = Genre.find_by_name(gets.chomp)
    return if genre.nil?

    sort_class(genre.songs).each_with_index do |song, i|
      puts "#{i + 1}. #{song.to_string(:artist)}"
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.chomp.downcase
    songs = sort_class(Song.all)
    song_list = songs.each_with_index.map do |song, i|
      "#{i + 1} #{song.name}"
    end
    return unless input.to_i > 1 && song_list.join(" ").include?(input)

    if input.to_i < songs.length
      song = songs[input.to_i - 1]
    else
      song = songs.find{ |var| var.name == input }
    end
    puts "Playing #{song.name} by #{song.artist.name}"
  end

  def sort_class(array)
    array.sort_by(&:name).uniq
  end
end
