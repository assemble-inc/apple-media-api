require 'apple/relation'

module Apple
  module Music
    module Relation
      class Playlists < Apple::Relation
        
        def item_klass
          Apple::Music::Playlist
        end
        
      end
    end
  end
end
