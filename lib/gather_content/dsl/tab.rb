require 'gather_content/config/tab'
require 'gather_content/dsl/text'
require 'gather_content/dsl/files'
require 'gather_content/dsl/choice_checkbox'
require 'gather_content/dsl/choice_radio'
require 'gather_content/dsl/section'

module GatherContent
  module DSL
    class Tab
      def initialize(builder)
        @tab = GatherContent::Config::Tab.new
        builder.tabs << @tab
      end

      def label(label)
        @tab.label = label
      end

      def name(name)
        @tab.name = name
      end

      def hidden(hidden)
        @tab.hidden = hidden
      end

      def text(&block)
        dsl = GatherContent::DSL::Text.new(@tab)
        dsl.instance_eval(&block)
      end

      def files(&block)
        dsl = GatherContent::DSL::Files.new(@tab)
        dsl.instance_eval(&block)
      end

      def choice_radio(&block)
        dsl = GatherContent::DSL::ChoiceRadio.new(@tab)
        dsl.instance_eval(&block)
      end

      def choice_checkbox(&block)
        dsl = GatherContent::DSL::ChoiceCheckbox.new(@tab)
        dsl.instance_eval(&block)
      end

      def section(&block)
        dsl = GatherContent::DSL::Section.new(@tab)
        dsl.instance_eval(&block)
      end
    end
  end
end
