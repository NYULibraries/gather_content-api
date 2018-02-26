module GatherContent
  module Api
    class Account < Base
      attr_accessor :account_id

      def initialize(account_id)
        raise ArgumentError, "account_id is required!" if account_id.nil?
        @account_id = account_id
      end

      def get_account
        @get_account ||= JSON.parse(get.body)
      end

    private

      def path
        @path ||= "/accounts/#{account_id}"
      end

      def params; end
    end
  end
end
