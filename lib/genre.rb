class Genre
  attr_accessor :name
  extend Concerns::Findable

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def songs
    @songs
  end

  def self.all
    @@all
  end

  def save
    @@all << self
    self
  end

  def self.create(name)
    new(name).save
  end

  def self.destroy_all
    @@all.clear
  end

  def artists
    songs.map do |song|
      song.artist
    end
    .uniq
  end
end