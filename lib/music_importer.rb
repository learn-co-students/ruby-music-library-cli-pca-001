class MusicImporter
  attr_accessor :path
  def initialize(path)
    @path = path
  end

  def files
    files = Dir["#{@path}/*"]
    files.map{ |file|file.split("/")[-1] }
  end

  def import
    files.each{ |file_name| Song.create_from_filename(file_name) }
  end
end
