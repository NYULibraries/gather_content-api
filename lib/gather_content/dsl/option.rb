require 'gather_content/config/elements/option'
require 'gather_content/config/elements/other_option'

module GatherContent
  module DSL
    class Option
      def initialize(choice)
        @option = GatherContent::Config::Element::Option.new
        if choice.options.last.instance_of?(GatherContent::Config::Element::OtherOption)
          choice.options.insert(-2, @option)
        else
          choice.options << @option
        end
      end

      def name(name)
        @option.name = name
      end

      def label(label)
        @option.label = label
      end

      def selected(selected)
        @option.selected = selected
      end
    end
  end
end
