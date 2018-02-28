module GatherContent
  module Api
    class Template < Base
      attr_accessor :template_id

      def initialize(template_id, data = nil)
        raise ArgumentError, "Template_id is required!" if template_id.nil?
        @template_id = template_id
        @data = data
      end

      def [](key)
        fetch[key]
      end

    private

      def path
        @path ||= "/templates/#{template_id}"
      end

      def params; end
    end
  end
end
