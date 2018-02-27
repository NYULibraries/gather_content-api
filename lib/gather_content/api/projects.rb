module GatherContent
  module Api
    class Projects < Base
      attr_accessor :account_id
      include Enumerable

      def initialize(account_id)
        raise ArgumentError, "account_id is required!" if account_id.nil?
        @account_id = account_id
      end

      def each(&block)
        fetch.each do |project|
          yield GatherContent::Api::Project.new(project['id'], project)
        end
      end

    private

      def params
        { account_id: @account_id }
      end

      def path
        @path ||= '/projects'
      end
    end
  end
end
