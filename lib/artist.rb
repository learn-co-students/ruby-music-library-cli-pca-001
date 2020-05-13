require "concerns/findable.rb"

class Artist
  attr_accessor :name
  attr_reader :songs
  extend Concerns::Findable
  extend Concerns::Listable

  def initialize(name)
    @name = name
    @songs = []
  end

  class << self
    def all
      @@all ||= []
    end

    def destroy_all
      all.clear
    end

    def create(name)
      new(name).tap(&:save)
    end
  end

  def save
    self.class.all << self
  end

  def add_song(song)
    song.artist = self unless song.artist
    @songs << song unless @songs.include? song
  end

  def genres
    songs.map(&:genre).uniq
  end

  def to_s
    @name
  end
end
