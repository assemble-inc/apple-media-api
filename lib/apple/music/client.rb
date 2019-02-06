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

      def base_class
        Apple::Music
      end

      def find_types
        {
          albums: :album,
          'music-videos': :music_video,
          playlists: :playlist,
          songs: :song,
          stations: :station,
          artists: :artist,
          curators: :curator,
          activities: :activity,
          'apple-curators': :apple_curator
        }.freeze
      end
    end
  end
end
