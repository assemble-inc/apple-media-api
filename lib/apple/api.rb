require 'apple/api/utils'
require 'apple/api/search'
require 'apple/api/charts'

module Apple
    module API
      include Apple::API::Utils
      include Apple::API::Search
      include Apple::API::Charts
    end
end
