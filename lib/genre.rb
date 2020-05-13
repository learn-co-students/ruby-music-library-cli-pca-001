class Genre
  extend Concerns::Findable
  extend Concerns::ClassMethods
  include Concerns::InstanceMethods
  attr_accessor :name, :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
    save
  end

  def add_song(song)
    return if song.nil?

    @songs << song unless @songs.include?(song)
    @songs.last.genre = self if @songs.last.genre.nil?
    @songs.last
  end

  def artists
    Song.all.select { |song| song.genre == self }.map(&:artist).uniq
  end

  def self.all
    @@all
  end
end
