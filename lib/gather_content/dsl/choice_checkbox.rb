require 'gather_content/dsl/base'
require 'gather_content/config/elements/choice_checkbox'
require 'gather_content/dsl/option'

module GatherContent
  module DSL
    class ChoiceCheckbox < Base
      def initialize(tab)
        @choice_checkbox = GatherContent::Config::Element::ChoiceCheckbox.new
        super(tab, @choice_checkbox)
      end

      def option(&block)
        dsl = GatherContent::DSL::Option.new(@choice_checkbox)
        dsl.instance_eval(&block)
      end
    end
  end
end
