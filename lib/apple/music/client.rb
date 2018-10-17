require 'apple/client'
require 'apple/music/api'

module Apple
  module Music
    class Client
      include Apple::Client
      include Apple::Music::API

      def url
        "https://api.music.apple.com/".freeze
      end
    end
  end
end
