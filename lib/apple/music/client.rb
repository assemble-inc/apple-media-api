require 'apple/client'

module Apple
  module Music
    class Client
      include Apple::Client
      def url
        "http://api.music.apple.com".freeze
      end
    end
  end
end
