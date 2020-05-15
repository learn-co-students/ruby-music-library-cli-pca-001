require 'pry'

class Song
  attr_accessor :name
  attr_reader :genre, :artist

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.all
    @@all
  end

  def self.destroy_all
    all.clear
  end

  def save
    @@all << self
    self
  end

  def self.create(name)
    new(name).save
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    return if genre.songs.include?(self)

    genre.songs << self
  end

  def self.find_by_name(name)
    all.detect { |song| song.name == name }
  end

  def self.find_or_create_by_name(name)
    song = find_by_name(name)
    if song.nil?
      create(name)
    else
      song
    end
  end

  def self.new_from_filename(filename)
    parts = filename.split(" - ")

    artist_name = parts.first
    song_name = parts[1]
    genre_name = parts[2].gsub(".mp3", "")

    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    new(song_name, artist, genre)
  end

  def self.create_from_filename(name)
    @@all << new_from_filename(name)
  end
end
