module GatherContent
  module Api

    class Statuses < Base
      attr_accessor :project_id
      include Enumerable

      def initialize(project_id)
        raise ArgumentError, "project_id is required!" if project_id.nil?
        @project_id = project_id
      end

      def each(&block)
        fetch.each do |status|
          yield GatherContent::Api::Status.new(@project_id, status['id'], status)
        end
      end

    private
      def path
        @path ||= "/projects/#{project_id}/statuses"
      end

      def params; end
    end
  end
end
