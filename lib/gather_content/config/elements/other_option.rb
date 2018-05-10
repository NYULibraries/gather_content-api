require 'gather_content/config/elements/option'

module GatherContent
  module Config
    module Element
      class OtherOption < Option
        attr_accessor :name, :label, :selected, :value

        def initialize(name = nil, label = nil, selected = nil, value = nil)
          super(name, label, selected)
          @value = value
        end

        def serialize(options = nil)
          base = super(options)

          value = !!selected ? self.value : ""

          base.merge({
            value: value
          })
        end
      end
    end
  end
end
