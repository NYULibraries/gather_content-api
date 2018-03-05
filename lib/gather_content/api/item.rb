require "base64"

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
        encoded = Base64.strict_encode64(config.to_json)
        result = post_json({config: encoded}, "#{path}/save")
        if result.status == 202
          true
        else
          raise GatherContent::Error::RequestError.new(result)
        end
      end

      def apply_template(template_id)
        post_save({ "template_id" => template_id }, "#{path}/apply_template")
      end

      def choose_status(status_id)
        post_save({ "status_id" => status_id }, "#{path}/choose_status")
      end

    private
      def post_save(params, path)
        result = post_json(params, path)
        if result.status == 202
          true
        else
          raise GatherContent::Error::RequestError.new(result)
        end
      end

      def path
        @path ||= "/items/#{item_id}"
      end

      def params; end
    end
  end
end
