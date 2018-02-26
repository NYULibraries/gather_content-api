module GatherContent
  module Api
    class Me < Base
      def initialize; end

      def get_me
        @get_me ||= JSON.parse(get.body)
      end

    private

      def path
        @path ||= "/me"
      end

      def params; end
    end
  end
end
