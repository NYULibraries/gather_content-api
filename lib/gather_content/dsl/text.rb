require 'gather_content/dsl/base'
require 'gather_content/config/elements/text'

module GatherContent
  module DSL
    class Text < Base
      def initialize(tab)
        @text = GatherContent::Config::Element::Text.new
        super(tab, @text)
      end

      def value(value)
        @text.value = value
      end

      def limit_type(limit_type)
        @text.limit_type = limit_type
      end

      def limit(limit)
        @text.limit = limit
      end

      def plain_text(plain_text)
        @text.plain_text = plain_text
      end
    end
  end
end
