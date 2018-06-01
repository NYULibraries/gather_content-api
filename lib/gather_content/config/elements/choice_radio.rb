require 'gather_content/config/elements/base'
require 'gather_content/config/elements/option'
require 'gather_content/config/elements/other_option'

module GatherContent
  module Config
    module Element
      class ChoiceRadio < Base
        attr_accessor :other_option, :options

        def initialize(name = "", required = false, label = "", microcopy = "", other_option = false)
          super(name, required, label, microcopy)
          @other_option = other_option
          @options = []
        end

        def serialize(_options = nil)
          raise ArgumentError, "You need to supply at least one option" if options.size == 0

          if other_option
            verify_other_option_types!(options)
          else
            verify_option_types!(options)
          end

          verify_options!(options)

          super.merge({
            type: 'choice_radio',
            other_option: !!other_option,
            options: options.map{ |el| el.serialize(_options) }
          })
        end

        def to_json(options = nil)
          serialize.to_json(options)
        end


      private
        def verify_other_option_types!(options)
          cleaned = options.select{ |opt| opt.is_a?(GatherContent::Config::Element::Option) }
          last = cleaned.pop

          raise ArgumentError, "Options can only be GatherContent::Config::Element::Option" if cleaned.size == 0
          raise ArgumentError, "The last option must be a GatherContent::Config::Element::OptionOther" unless last.instance_of?(GatherContent::Config::Element::OtherOption)
        end

        def verify_option_types!(options)
          cleaned = options.select{ |opt| opt.instance_of?(GatherContent::Config::Element::Option) }

          raise ArgumentError, "Options can only be GatherContent::Config::Element::Option" if cleaned.size == 0
        end

        def verify_options!(options)
          selected = options.select{ |opt| opt.selected }
          raise ArgumentError, "You can't select more than one ChoiceRadio Option" if selected.size > 1
        end
      end
    end
  end
end
