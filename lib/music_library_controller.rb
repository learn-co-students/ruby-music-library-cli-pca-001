

class MusicLibraryController

  def initialize(path = "./db/mp3s")
    @path = path
    @importer = MusicImporter.new(path).import
  end

  def call
    introduction
    help
    puts "What would you like to do?"

    input = get_input
    until input == "exit"
      case input
      when "help"
        help
      when "list songs"
        list_songs
      when "list genres"
        list_genres
      when "list artists"
        list_artists
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      end


      input = get_input
    end

  end

  def help
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
  end

  def introduction
    puts "Welcome to your music library!"
  end

  def get_input
    gets.chomp
  end

  def list_songs
    # print_song_list(Song.all)
    Song.list_all_alpha_by_name
  end

  def list_artists
    Artist.list_all_alpha_by_name
  end

  def list_genres
    Genre.list_all_alpha_by_name
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist = Artist.find_by_name(get_input)
    print_artist_song_list(artist.songs) if artist
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre = Genre.find_by_name(get_input)
    print_genre_song_list(genre.songs) if genre
  end

  def play_song
    puts "Which song number would you like to play?"
    input = get_input
    # binding.pry
    song = Song.find_from_user_input(input)
    puts "Playing #{song.name} by #{song.artist.name}" if song
  end

  def print_artist_song_list(song_list)
    song_list.sort_by(&:name).each_with_index do |song, i|
      puts "#{i + 1}. #{song.name} - #{song.genre.name}"
    end
  end

  def print_genre_song_list(song_list)
    binding.pry
    song_list.sort_by(&:name).each_with_index do |song, i|
      puts "#{i + 1}. #{song.artist} - #{song.name}"
    end
  end

    # def print_song_list(song_list, with_artist = true)
  #   song_list.sort_by(&:name).each_with_index do |song, i|
  #     puts "#{i + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
  #   end
  # end

end
