module GatherContent
  module Api
    class Item < Base
      attr_accessor :item_id

      def initialize(item_id, data = nil)
        raise ArgumentError, "Item_id is required!" if item_id.nil?
        @item_id = item_id
        @data = data
      end

      def [](key)
        fetch[key]
      end

    private

      def path
        @path ||= "/items/#{item_id}"
      end

      def params; end
    end
  end
end
