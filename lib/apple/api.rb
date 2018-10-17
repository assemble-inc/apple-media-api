require 'apple/api/utils'
require 'apple/api/search'
require 'apple/music/api'
module Apple
    module API
      include Apple::API::Utils
      include Apple::API::Search
      include Apple::Music::API
    end
end
