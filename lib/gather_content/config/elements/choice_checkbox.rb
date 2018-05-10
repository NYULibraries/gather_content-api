require 'gather_content/config/elements/base'
require 'gather_content/config/elements/option'

module GatherContent
  module Config
    module Element
      class ChoiceCheckbox < Base
        attr_accessor :options

        def initialize(name = "", required = false, label = "", microcopy = "")
          super(name, required, label, microcopy)
          @options = []
        end

        def serialize(_options = nil)
          cleaned = options.select{ |opt| opt.instance_of?(GatherContent::Config::Element::Option) }
          raise ArgumentError, "You need to supply at least one option" if options.size == 0
          raise ArgumentError, "Options can only be GatherContent::Config::Element::Option" if cleaned.size == 0

          super.merge({
            type: 'choice_checkbox',
            options: options.map{ |el| el.serialize(_options) }
          })
        end

        def to_json
          serialize.to_json
        end
      end
    end
  end
end
