require 'apple/relation'

module Apple
  module Music
    module Relation
      class Artists < Apple::Relation
        
        def item_klass
          Apple::Music::Artist
        end
        
      end
    end
  end
end
