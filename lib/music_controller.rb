require 'pry'

class MusicLibraryController
  attr_accessor :path, :lib
  def initialize(path="./db/mp3s")
    @path = path
    importer = MusicImporter.new(path)
    @lib = importer.import
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
    Song.all.sort{ |a,b| a.name <=> b.name }.uniq.each_with_index{ |song, i| puts "#{i + 1}. #{song.to_s}" }
  end

  def list_artists
    Artist.all.sort{ |a,b| a.name <=> b.name }.uniq.each_with_index { |artist, i| puts "#{i + 1}. #{artist.name}" }
  end

  def list_genres
    Genre.all.sort{ |a,b| a.name <=> b.name }.uniq.each_with_index { |genre, i| puts "#{i + 1}. #{genre.name}" }
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist = Artist.find_by_name(gets.chomp)
    artist.nil? ? "none" : artist.songs.sort_by(&:name).uniq.each_with_index do |song, i|
      tmp = "#{song.name} - #{song.genre.name}"
      puts "#{i + 1}. #{tmp}"
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre = Genre.find_by_name(gets.chomp)
    genre.nil? ? "none" :  Song.all.select{ |song| song.genre == genre }.uniq.sort_by(&:name).each_with_index do |song, i|
      puts"#{i + 1}. #{song.artist.name} - #{song.name}"
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    tmp = gets.chomp.downcase
    songs_object = Song.all.uniq
    return if tmp.to_i < 1 || tmp.to_i > songs_object.count
    # my answer was off by one originally, but the nique step fails that, must be somewhere else
    song_names = songs_object.map(&:name).each_with_index.map{ |song, i| "#{i}. #{song}"}
    selection = song_names.find{ |song| song.include? tmp }
    index = song_names.index(selection)
    puts "Playing #{songs_object[index].name} by #{songs_object[index].artist.name}" unless selection.nil?
  end
end
