require 'pry'

class Genre
    extend Concerns::Findable
    attr_accessor :name, :songs
    @@all = []

    def initialize(name)
        @name = name
        @songs = []
        save
    end

    def save
        @@all << self
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(genre)
        new(genre)
    end

    def artists
        @songs.map do |song|
            song.artist
        end .uniq
    end
end