require 'gather_content/config/elements/files'
require 'gather_content/config/elements/other_option'

module GatherContent
  module DSL
    class OtherOption < Option
      def initialize(choice)
        @option = GatherContent::Config::Element::OtherOption.new
        choice.other_option = true
        choice.options << @option
      end

      def value(value)
        @option.value = value
      end
    end
  end
end
