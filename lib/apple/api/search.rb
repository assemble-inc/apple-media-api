require 'apple/api/utils'

module Apple
  module API
    module Search
      include Apple::API::Utils

      def search(term, options={})
        res = perform_get("/v1/catalog/#{get_storefront}/search/", options.merge(term: term))
        if res && res[:results]
          res[:results].map do |type, hash|
            {
              type: type,
              adams: generate_objects(type, hash[:data]),
            }
          end
        end
      end

      def hint(term, options={})
        perform_get("/v1/catalog/#{get_storefront}/search/hints/", options.merge(term: term))
      end

    end
  end
end
