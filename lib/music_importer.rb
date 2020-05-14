require 'pry'
class MusicImporter
    attr_accessor :path, :files
    @path = []
    def initialize(path)
        @path= path
    end

    def files
        @files = Dir.entries(@path).select do |filename|
            !File.directory? filename
         end
    end

    def import
        files.each do |file|
            Song.create_from_filename(file)
        end
    end

end