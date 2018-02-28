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

      def save(config)

      end

      def apply_template(template_id)
        result = post({ "template_id" => template_id }, "#{path}/apply_template")
        if result.status == 202
          true
        else
          raise GatherContent::Error::RequestError.new(result)
        end
      end

      def choose_status(status_id)
        result = post({ "status_id" => status_id }, "#{path}/choose_status")
        if result.status == 202
          true
        else
          raise GatherContent::Error::RequestError.new(result)
        end
      end

    private

      def path
        @path ||= "/items/#{item_id}"
      end

      def params; end
    end
  end
end
