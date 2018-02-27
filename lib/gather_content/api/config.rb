module GatherContent
  module Api
    class Config
      attr_writer :username, :api_key

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

    private
      def initialize
      end
    end
  end
end
