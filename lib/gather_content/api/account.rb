module GatherContent
  module Api
    class Account < Base
      attr_accessor :account_id

      def initialize(account_id, data = nil)
        raise ArgumentError, "account_id is required!" if account_id.nil?
        @account_id = account_id
        @data = data
      end

      def [](key)
        fetch[key]
      end

    private

      def path
        @path ||= "/accounts/#{account_id}"
      end

      def params; end
    end
  end
end
