require 'apple/relation'

module Apple
  module Music
    module Relation
      class Tracks < Apple::Relation
        
        def item_klass
          Apple::Music::Song
        end
        
        def full_items?
          true
        end
        
      end
    end
  end
end
