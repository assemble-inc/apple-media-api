require 'jwt'
require 'apple/api'

module Apple
  module Client
    include Apple::API

    attr_reader :token

    def initialize(storefront: nil)
      set_storefront(storefront || 'us')
      generate_token
    end

    def generate_token
      secret_key = Apple.configuration.secret_key
      ec = OpenSSL::PKey::EC.new(secret_key)
      algorithm = Apple.configuration.algorithm

      @token = JWT.encode(payload, ec, algorithm, header_fields)
    end

    def set_storefront(new_storefront)
      @storefront = new_storefront
    end

    def get_storefront
      @storefront
    end

    def base_class
      Apple
    end

    def find_types
      {}.freeze
    end

    def find(adam_type, id, options={})
      query_method = find_types[adam_type.to_sym]

      raise(Apple::Error::QueryError, "Cant query: #{adam_type}") if query_method.nil?

      send(query_method, id, options)
    end

    protected

    def header_fields
      {
        alg: Apple.configuration.algorithm,
        kid: Apple.configuration.key_id
      }
    end

    def payload
      time = Time.now.to_i
      {
        iss: Apple.configuration.team_id,
        iat: time,
        exp: (time + TOKEN_LIFETIME_SEC)
      }
    end

    # one week
    TOKEN_LIFETIME_SEC = 7 * 24 * 60 * 60
    private_constant :TOKEN_LIFETIME_SEC
  end
end
