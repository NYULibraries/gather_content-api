module GatherContent
  module Api
    class Accounts < Base
      include Enumerable

      def initialize; end

      def to_a(accounts = [])
        JSON.parse(get.body)['data'].each do |account|
          new_account = account_class.new(account['id'])
          accounts << new_account
        end
        return accounts
      end

      def each(&block)
        self.to_a.each(&block)
      end

    protected

      def account_class
        @account_class ||= Kernel.const_get("GatherContent::Api::Account")
      end

    private

      def params; end

      def path
        @path ||= '/accounts'
      end

    end
  end
end
