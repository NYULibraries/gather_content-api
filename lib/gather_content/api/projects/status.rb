module GatherContent
  module Api
    class Status < Base
      attr_accessor :project_id, :status_id

      def initialize(project_id, status_id, data = nil)
        raise ArgumentError, "project_id is required!" if project_id.nil?
        raise ArgumentError, "status_id is required!" if status_id.nil?
        @project_id = project_id
        @status_id = status_id
        @data = data
      end

      def [](key)
        fetch[key]
      end

    private
      def path
        @path ||= "/projects/#{project_id}/statuses/#{status_id}"
      end

      def params; end
    end
  end
end
