require 'pry'

class Artist
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

    def self.create(artist)
        new(artist)
    end

    def add_song(song)
        song.artist = self if !song.artist
        self.songs << song if !songs.include?(song)
    end

    def genres
        @songs.map do |song|
            song.genre
        end.uniq
    end
end