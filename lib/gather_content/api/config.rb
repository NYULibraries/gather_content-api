module GatherContent
  module Api
    class Config
      attr_writer :username, :api_key, :host, :port

      def self.run
        yield self.instance
      end

      def self.instance
        @instance ||= self.new
      end

      def username
        @username || ENV['GATHER_CONTENT_API_USERNAME']
      end

      def api_key
        @api_key || ENV['GATHER_CONTENT_API_KEY']
      end

      def host
        @host || ENV['GATHER_CONTENT_API_HOST'] || "https://api.gathercontent.com"
      end

      def port
        @port || ENV['GATHER_CONTENT_API_PORT'] || "443"
      end

    private
      def initialize
      end
    end
  end
end
