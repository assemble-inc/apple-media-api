require 'apple/relation'

module Apple
  module Music
    module Relation
      class Albums < Apple::Relation
        
        def item_klass
          Apple::Music::Album
        end
        
      end
    end
  end
end
