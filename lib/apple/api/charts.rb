require 'apple/api/utils'

module Apple
  module API
    module Charts
      include Apple::API::Utils

      def charts(**args)
        res = perform_get("/v1/catalog/#{get_storefront}/charts/", **args)
        return [] unless res && res[:results]

        res[:results].map do |type, charts|
          next [] if charts.nil?

          charts.map do |chart|
            {
              chart_name: chart[:name],
              type: type.to_s,
              chart: chart[:chart],
              adams: generate_objects(type, chart[:data])
            }
          end
        end.flatten
      end

      def chart(**args)
        return nil if args[:type].nil?
        args[:types] = args.delete :type
        res = charts(args)
        res.first if res
      end
    end
  end
end
