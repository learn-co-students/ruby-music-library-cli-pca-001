
class MusicImporter
  attr_accessor :path
  attr_reader :files

  def initialize(path)
    @path = path
    @files = []
    save_files
  end

  def save_files
    Dir.glob("#{@path}/*").each do |filename|
      File.open(filename, "r") do |file|
        @files << File.basename(file)
      end
    end
  end

  def import
    @files.each { |file| Song.create_from_filename(file) }
  end
end
