require 'net/http'
require 'uri'
require 'json'
require 'openssl'

module Apple
  module API
    class Request
      def initialize(client, request_method, path, options = {})
        @base_url = client.url
        @client = client
        @uri = URI.parse(path.start_with?('http') ? path : @base_url + path)
        @request_method = request_method
        @path = @uri.path
        @options = options
      end

      def perform
        response = case @request_method
        when :get
          perform_get
        else
          # raise some sort of error
          Apple::Error::BadRequestMethod.new(body, code)
        end

        fail_or_return_parsed_body(response.code, response.body)
      end

      def perform_get
        @uri.query = build_nested_query(clean_options)

        request = Net::HTTP::Get.new(@uri)
        request['Authorization'] = "Bearer #{@client.token}"

        Net::HTTP.start(@uri.hostname, @uri.port, use_ssl: true) do |http|
          http.request(request)
        end
      end

      private

      def fail_or_return_parsed_body(code, body)
        error = error(code, body)
        raise(error) if error

        symbolize_keys!(JSON.parse(body))
      end

      def error(code, body)
        # TODO: handle all status codes differently
        case code.to_i
        when 200
          return
        when 400
          Apple::Error::BadRequestMethod.new(body, code)
        when 404
          Apple::Error::NotFound.new(body, code)
        when 500
          Apple::Error::ServerError.new(body, code)
        else
          Apple::Error.new(body, code)
        end
      end

      def clean_options
        @options.reject{|k,v| v.nil? || (!v.is_a?(Integer) && v.empty?) }
      end

      def symbolize_keys!(object)
        if object.is_a?(Array)
          object.each_with_index do |val, index|
            object[index] = symbolize_keys!(val)
          end
        elsif object.is_a?(Hash)
          object.keys.each do |key|
            object[key.to_sym] = symbolize_keys!(object.delete(key))
          end
        end
        object
      end

      # From Rack::Utils.build_nested_query
      def build_nested_query(value, prefix = nil)
        case value
        when Array
          value.map { |v|
            build_nested_query(v, "#{prefix}[]")
          }.join('&')
        when Hash
          value.map { |k, v|
            build_nested_query(v, prefix ? "#{prefix}[#{escape(k)}]" : escape(k))
          }.reject(&:empty?).join('&')
        when nil
          prefix
        else
          raise ArgumentError, 'value must be a Hash' if prefix.nil?

          "#{prefix}=#{escape(value)}"
        end
      end

    end
  end
end
