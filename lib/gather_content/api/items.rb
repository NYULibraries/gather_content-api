module GatherContent
  module Api
    class Items < Base
      include Enumerable
      attr_accessor :project_id

      def initialize(project_id)
        raise ArgumentError, "Project_id is required!" if project_id.nil?
        @project_id = project_id
      end

      def each(&block)
        fetch.each do |item|
          yield GatherContent::Api::Item.new(item['id'], item)
        end
      end

    private
      def params
        { project_id: project_id }
      end

      def path
        @path ||= '/items'
      end

    end
  end
end
