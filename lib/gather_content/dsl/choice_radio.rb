require 'gather_content/dsl/base'
require 'gather_content/config/elements/choice_radio'
require 'gather_content/dsl/option'
require 'gather_content/dsl/other_option'

module GatherContent
  module DSL
    class ChoiceRadio < Base
      def initialize(tab)
        @choice_radio = GatherContent::Config::Element::ChoiceRadio.new
        super(tab, @choice_radio)
      end

      def option(&block)
        dsl = GatherContent::DSL::Option.new(@choice_radio)
        dsl.instance_eval(&block)
      end

      def other_option(&block)
        dsl = GatherContent::DSL::OtherOption.new(@choice_radio)
        dsl.instance_eval(&block)
      end
    end
  end
end
