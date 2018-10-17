require 'apple/relation'

module Apple
  module Music
    module Relation
      class Genres < Apple::Relation
        
        def item_klass
          Apple::Music::Genre
        end
        
      end
    end
  end
end
