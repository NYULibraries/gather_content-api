module GatherContent
  module Api
    class Base

      def initialize
        raise RuntimeError, "Cannot initialize this interface!"
      end

      def get
        connection.get do |request|
          request.url path
          request.params = params unless params.nil?
          request.headers['Accept'] = "application/vnd.gathercontent.v0.5+json"
        end
      end

      def fetch
        @data ||= parse(get.body)
      end

      def reset
        @data = nil
      end

    protected
      def parse(data)
        parsed = JSON.parse(data)
        parsed['data']
      end

      def params
        raise RuntimeError, "Expected this to be implemented in a subclass!"
      end

      def path
        raise RuntimeError, "Expected this to be implemented in a subclass!"
      end

    private
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
