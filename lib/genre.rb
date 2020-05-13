class Genre
  extend Concerns::Findable
  attr_accessor :name, :songs

  def initialize(name)
    @name = name
    @songs = []
    save
  end

  def save
    @@all << self
  end

  def artists
    Song.all.select{ |song| song.genre == self }.map(&:artist).uniq
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
