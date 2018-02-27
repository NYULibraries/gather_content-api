module GatherContent
  module Api
    class Projects < Base
      attr_accessor :account_id
      include Enumerable

      def initialize(account_id)
        raise ArgumentError, "account_id is required!" if account_id.nil?
        @account_id = account_id
      end

      def to_a(projects = [])
        JSON.parse(get.body)['data'].each do |project|
          new_project = project_class.new(project['id'])
          projects << new_project
        end
        return projects
      end

      def each(&block)
        self.to_a.each(&block)
      end

    protected

      def project_class
        @project_class ||= Kernel.const_get("GatherContent::Api::Project")
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
