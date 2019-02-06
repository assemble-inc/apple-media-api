module Apple
  class Error < StandardError
    attr_reader :code, :json

    # generic 4xx error
    ClientError = Class.new(self)

    # 404
    NotFound = Class.new(ClientError)

    # generic 5xx error
    ServerError = Class.new(self)

    # other errors
    BadRequestMethod = Class.new(self)
    SearchResultError = Class.new(self)
    QueryError = Class.new(self)

    ERRORS = {
      404 => Apple::Error::NotFound
    }.freeze

    def initialize(message = '', code = nil)
      super(message)
      @json =
        begin
          JSON.parse(message)
        rescue JSON::ParserError
          { message: message }
        end
      @code = code
    end
  end
end
