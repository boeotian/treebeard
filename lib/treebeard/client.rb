module Treebeard
  class Client
    attr_reader :token

    BASE_URI = 'https://lichess.org'

    def initialize(token)
      @token = token
      @base_uri = BASE_URI

      @api = Faraday.new(
        @base_uri,
        headers: { "User-Agent" => "Treebeard v#{VERSION} (https://github.com/boeotian/treebeard)" }
      ) do |conn|
        conn.request :json
        conn.response :json
        conn.response :raise_error
        conn.request :retry, retry_options if retry_options
        conn.adapter Faraday.default_adapter
      end
    end

    def get(url, body: nil)
      api.get(url.sub(/^\//, ''), body, { 'Authorization' => "Bearer #{token}" }).body
    end

    def post(url, body: nil)
      api.post(url.sub(/^\//, ''), body, { 'Authorization' => "Bearer #{token}" }).body
    end
  end
end