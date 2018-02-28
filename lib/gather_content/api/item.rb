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

      end

      def choose_status(status_id)
        result = post({ "item_id" => @item_id, "status_id" => status_id }, "#{path}/choose_status")
        if result.status == 202
          true
        else
          parsed = JSON.parse(result.body)

          if parsed.is_a?(Hash) && parsed['data']
            if parsed['data'].is_a?(Hash) && parsed['data']['message']
              raise GatherContent::Error::RequestError.new(parsed['data']['message'], result.status)
            elsif parsed['data'].is_a?(Array)
              raise GatherContent::Error::RequestError.new(parsed['data'].join(''), result.status)
            else
              raise GatherContent::Error::RequestError.new(parsed['data'], result.status)
            end
          else
            raise GatherContent::Error::RequestError.new(result.body, result.status)
          end
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
