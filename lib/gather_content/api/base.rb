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

    protected

      def params
        raise RuntimeError, "Expected this to be implemented in a subclass!"
      end

      def path
        raise RuntimeError, "Expected this to be implemented in a subclass!"
      end

    private

      def gather_content_api_host
        ENV['gather_content_api_host'] || 'https://api.gathercontent.com'
      end

      def gather_content_api_port
        ENV['gather_content_api_port'] || '443'
      end

      def connection
        config = GatherContent::Api::Config.instance

        @connection ||= Faraday.new(url: "#{gather_content_api_host}:#{gather_content_api_port}") do |faraday|
          faraday.request  :url_encoded
          faraday.request  :basic_auth, config.username, config.api_key
          # faraday.response :logger
          faraday.adapter  Faraday.default_adapter
        end
      end
    end
  end
end
