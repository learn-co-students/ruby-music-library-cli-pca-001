require "concerns/findable.rb"

class Artist
  attr_accessor :name
  attr_reader :songs
  extend Concerns::Findable
  extend Concerns::Listable
  extend Concerns::Nameable
  extend Concerns::Persistable::ClassMethods
  include Concerns::Persistable::InstanceMethods

  def initialize(name)
    @name = name
    @songs = []
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
