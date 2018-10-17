require 'apple/api'
require 'apple/configuration'
require 'apple/client'
require 'apple/version'
require 'apple/error'
require 'apple/base'

require 'apple/music/activity'
require 'apple/music/album'
require 'apple/music/apple_curator'
require 'apple/music/artist'
require 'apple/music/curator'
require 'apple/music/genre'
require 'apple/music/music_video'
require 'apple/music/playlist'
require 'apple/music/song'
require 'apple/music/station'

module Apple
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Apple::Configuration.new
  end

  def self.configure
    yield(configuration) if block_given?
  end
end
