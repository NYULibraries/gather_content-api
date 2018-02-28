module GatherContent
  module Api
    class Files < Base
      attr_accessor :item_id
      include Enumerable

      def initialize(item_id)
        raise ArgumentError, "item_id is required!" if item_id.nil?
        @item_id = item_id
      end

      def each(&block)
      fetch.each do |file|
        yield GatherContent::Api::File.new(@item_id, file['id'], file)
      end
    end

    private

      def path
        @path ||= "/items/#{item_id}/files"
      end

      def params; end
    end
  end
end
