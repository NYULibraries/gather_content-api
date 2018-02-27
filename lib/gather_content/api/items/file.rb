module GatherContent
  module Api
    class File < Base
      attr_accessor :file_id

      def initialize(item_id, file_id)
        raise ArgumentError, "item_id is required!" if item_id.nil?
        raise ArgumentError, "file_id is required!" if file_id.nil?
        @project_id = project_id
        @file_id = file_id
      end
    end
  end
end
