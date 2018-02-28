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

      def create(data)
        data.delete("type") if data["type"].nil? || data["type"].empty?

        raise ArgumentError, "name is required!" if data["name"].nil? || data["name"].empty?
        raise ArgumentError, "type is invalid!" unless valid_type?(data["type"])

        result = post(data.merge({ 'account_id' => @account_id }))

        if result.status == 202
          project_id = result.headers['location'].split('/').last
          GatherContent::Api::Project.new(project_id)
        else
          parsed = JSON.parse(result.body)

          if parsed.is_a?(Hash) && parsed['data'] && parsed['data']['message']
            raise GatherContent::Error::RequestError.new(parsed['data']['message'], result.status)
          else
            raise GatherContent::Error::RequestError.new(result.body, result.status)
          end
        end
      end

    private

      def params
        { account_id: @account_id }
      end

      def path
        @path ||= '/projects'
      end

      def valid_type?(type)
        return type = "other" if type.nil? || type.empty?
        types = %w{website-build ongoing-website-content marketing-editorial-content email-marketing-content other}
        types.include?(type)
      end
    end
  end
end
