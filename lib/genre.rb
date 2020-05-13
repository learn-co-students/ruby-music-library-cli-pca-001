require "concerns/findable.rb"

class Genre
  attr_accessor :name
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

  def songs
    @songs
  end

  def add_song(song)
    song.genre = self unless song.genre
    @songs << song unless @songs.include? song
  end

  def artists
    songs.map(&:artist).uniq
  end

  def to_s
    @name
  end
end
