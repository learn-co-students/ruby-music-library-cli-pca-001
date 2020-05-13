require "concerns/findable.rb"

class Song
  @@all = []
  attr_accessor :name
  attr_reader :artist, :genre
  extend Concerns::Findable
  extend Concerns::Listable

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  class << self
    def all
      @@all
    end

    def destroy_all
      all.clear
    end

    def create(name)
      new(name).tap(&:save)
    end

    def new_from_filename(filename)
      # "Artist - SongName - Genre"
      info = filename.split(" - ")
      artist = Artist.find_or_create_by_name(info[0])
      genre = File.basename(info[2], File.extname(info[2]))
      genre = Genre.find_or_create_by_name(genre)

      new(info[1], artist, genre)
    end

    # finds the song based on some user input
    # numbered list or string match
    def find_from_user_input(input)
      index = input.to_i - 1

      if index >= 0
        all.sort_by(&:name)[index]
      else
        find_by_name(input)
      end
    end

    def create_from_filename(filename)
      new_from_filename(filename).tap(&:save)
    end
  end

  def save
    self.class.all << self
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def to_s
    "#{@artist.name} - #{@name} - #{@genre.name}"
  end
end
