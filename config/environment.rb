require 'bundler'
Bundler.require
require 'pry'

require_relative "../lib/concerns/findable.rb"
require_relative "../lib/artist.rb"
require_relative "../lib/song.rb"
require_relative "../lib/genre.rb"
require_relative  "../lib/music_controller.rb"

require_all 'lib'
