module GatherContent
  module Api
    class Me < Base
      def initialize; end

      def [](key)
        fetch[key]
      end

    private

      def path
        @path ||= "/me"
      end

      def params; end
    end
  end
end
