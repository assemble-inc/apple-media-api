require 'apple/api/utils'
require 'apple/api/search'
require 'apple/music/api'
require 'apple/books/api'
module Apple
    module API
      include Apple::API::Utils
      include Apple::API::Search
      include Apple::Music::API
      include Apple::Books::API
    end
end
