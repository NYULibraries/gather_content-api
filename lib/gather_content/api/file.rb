module GatherContent
  module Api
    class File < Base
      attr_accessor :file_id

      def initialize(item_id, file_id, data)
        raise ArgumentError, "item_id is required!" if item_id.nil?
        raise ArgumentError, "file_id is required!" if file_id.nil?
        @item_id = item_id
        @file_id = file_id
        @data = data
      end

      def [](key)
        @data[key]
      end
    end
  end
end
