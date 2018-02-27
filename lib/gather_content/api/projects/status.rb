module GatherContent
  module Api
    class Item < Base
      attr_accessor :item_id

      def initialize(project_id, status_id)
        raise ArgumentError, "project_id is required!" if project_id.nil?
        raise ArgumentError, "status_id is required!" if status_id.nil?
        @project_id = project_id
        @status_id = status_id
      end

      def get_item
        @get_item ||= JSON.parse(get.body)
      end

    private

      def path
        @path ||= "/projects/#{project_id}/statuses/#{status_id}"
      end

      def params; end
    end
  end
end
