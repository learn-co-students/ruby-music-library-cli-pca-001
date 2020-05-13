require "concerns/findable.rb"
require "concerns/listable.rb"

class Genre
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
