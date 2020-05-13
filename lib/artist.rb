require 'pry'

class Artist
  extend Concerns::Findable
  # wanted to make `Song` the source of truth, but tests
  # are invoking `<<` on `@songs`, which I can't find a better way arround...
  attr_accessor :name, :songs

  def initialize(name, song = nil)
    @name = name
    @songs = []
    add_song unless song.nil?
    save
  end

  def save
    @@all << self
  end

  # adds a song to an artist
  def add_song(new_song)
    found_song = @songs.find { |song| song == new_song }
    return unless found_song.nil? && new_song.artist.nil?

    new_song.artist = self
    @songs << new_song
    new_song
  end

  # returns all genres associated with the artist
  def genres
    Song.all.select{ |song| song.artist == self }.map(&:genre).uniq
  end

  class << self
    @@all = []
    def all
      @@all
    end

    def destroy_all
      @@all.clear
    end

    def create(name)
      new(name)
    end
  end
end
