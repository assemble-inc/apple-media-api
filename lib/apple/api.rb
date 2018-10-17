require 'apple/api/utils'
require 'apple/api/search'
require 'apple/books/api'
require 'apple/music/api'
module Apple
    module API
      include Apple::API::Utils
      include Apple::API::Search
      include Apple::Music::API
      include Apple::Books::API
    end
end
