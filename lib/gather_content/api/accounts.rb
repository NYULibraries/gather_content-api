module GatherContent
  module Api
    class Accounts < Base
      include Enumerable

      def initialize; end

      def each(&block)
        fetch.each do |account|
          yield GatherContent::Api::Account.new(account['id'], account)
        end
      end

    private

      def params; end

      def path
        @path ||= '/accounts'
      end
    end
  end
end
