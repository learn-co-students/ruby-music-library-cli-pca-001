class Song
  extend Concerns::Findable
  extend Concerns::ClassMethods
  include Concerns::InstanceMethods
  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist
    self.genre = genre
    save
  end

  def artist=(artist)
    return if artist.nil?

    @artist = artist if @artist.nil?
    @artist.add_song(self) unless @artist.songs.include?(self)
  end

  def genre=(genre)
    return if genre.nil?

    @genre = genre if @genre.nil?
    @genre.add_song(self) unless @genre.songs.include?(self)
  end

  def to_string(args="")
    case args
    when :genre
      "#{@name} - #{@genre.name}"
    when :artist
      "#{artist.name} - #{@name}"
    else
      "#{@artist.name} - #{@name} - #{@genre.name}"
    end
  end

  class << self
    def all
      @@all
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
      new_from_filename(file_name)
    end
  end
end
