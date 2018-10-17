require 'jwt'
require 'apple/api'

module Apple
  class Client
    include Apple::API

    attr_reader :token

    def initialize(storefront: nil, realm: nil)
      set_storefront(storefront || 'us')
      set_realm(realm || 'music')
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

    def set_realm(new_realm)
      @realm = new_realm
    end

    def get_realm
      @realm
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
