require 'apple/api/request'

module Apple
  module API
    module Utils
      def perform_get(path, options = {})
        perform_request(:get, path, options)
      end

      def perform_request(request_method, path, options = {})
        Apple::API::Request.new(self, request_method, path, options).perform
      end

      def perform_get_object(klass, path, options = {})
        result = perform_get(path, options)
        klass.new(result[:data].first, options, self)
      end

      def perform_get_objects(klass, path, options = {})
        results = perform_get(path, options)

        results[:data].collect do |item|
          klass.new(item, options, self)
        end
      end

      def get_class(type)
        base_class.const_get(type_to_const_string(type))
      rescue NameError
        raise Apple::Error::SearchResultError, "Cant handle results type: #{type}"
      end

      def generate_objects(type, data)
        return [] if !data
        klass = get_class(type)
        data.map { |adam| klass.new(adam) }
      end

      def type_to_const_string(type)
        parts = type.to_s.split('-').map(&:capitalize)
        last = parts.pop

        parts <<
          case last
          when 'Activities'
            'Activity'
          when 'Series'
            'Series'
          else
            last[0...-1]
          end

        parts.join('')
      end
    end
  end
end
