module GatherContent
  module Api
    class Base

      def initialize
        raise RuntimeError, "Cannot initialize this interface!"
      end

      def get(path_override = nil)
        connection.get do |request|
          request.url(path_override || path)
          request.params = params unless params.nil?
          request.headers['Accept'] = "application/vnd.gathercontent.v0.5+json"
        end
      end

      def post(data = {}, path_override = nil)
        connection.post do |request|
          request.url(path_override || path)
          request.body = data
          request.headers['Accept'] = "application/vnd.gathercontent.v0.5+json"
          yield request if block_given?
        end
      end

      def post_json(data = {}, path_override = nil)
        post(data.to_json, path_override) do |request|
          request.headers['Content-type'] = "application/json"
        end
      end

      def fetch
        @data ||= parse(get.body)
      end

      def reset
        @data = nil
      end

    protected
      def params
        raise RuntimeError, "Expected this to be implemented in a subclass!"
      end

      def path
        raise RuntimeError, "Expected this to be implemented in a subclass!"
      end

    private
      def parse(data)
        parsed = JSON.parse(data)
        parsed['data']
      end

      def connection
        config = GatherContent::Api::Config.instance

        @connection ||= Faraday.new(url: "#{config.host}:#{config.port}") do |faraday|
          faraday.request  :url_encoded
          faraday.request  :basic_auth, config.username, config.api_key
          # faraday.response :logger
          faraday.adapter  Faraday.default_adapter
        end
      end
    end
  end
end
