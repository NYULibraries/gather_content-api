module GatherContent
  module Api
    class Project < Base
      attr_accessor :project_id

      def initialize(project_id, data = nil)
        raise ArgumentError, "project_id is required!" if project_id.nil?
        @project_id = project_id
        @data = data
      end

      def [](key)
        fetch[key]
      end

    private

      def path
        @path ||= "/projects/#{project_id}"
      end

      def params; end
    end
  end
end
