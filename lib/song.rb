class Song
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    # calling with artist= instead of @artist
    self.artist = artist
    self.genre = genre
    save
  end

  def save
    @@all << self
  end

  def artist=(artist)
    @artist = artist
    return if artist.nil?

    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    return if genre.nil?

    genre.songs << self unless genre.songs.include?(self)
  end

  def to_s
    "#{@artist.name} - #{@name} - #{@genre.name}"
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

    def new_from_filename(file_name)
      tmp = file_name.split(/\s-\s|\./)
      new_artist = Artist.find_or_create_by_name(tmp[0])
      song = new_artist.add_song(Song.find_or_create_by_name(tmp[1]))
      song.genre = Genre.find_or_create_by_name(tmp[2])
      song
    end

    # songs are already saved on creation though with `save` at the end of initialize???
    def create_from_filename(file_name)
      new_from_filename(file_name).save
    end
  end
end
