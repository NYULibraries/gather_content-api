module GatherContent
  module Config
    module Element
      class Base
        attr_accessor :name, :required, :label, :microcopy

        def initialize(name = nil, required = nil, label = nil, microcopy = nil)
          @name = name
          @required = required
          @label = label
          @microcopy = microcopy
        end

        def serialize(options = nil)
          raise ArgumentError, "name is required" unless name.present?
          raise ArgumentError, "label is required" unless label.present?

          {
            name: name,
            required: !!required,
            label: label,
            microcopy: microcopy
          }
        end

        def to_json(options = nil)
          serialize.to_json(options)
        end
      end
    end
  end
end
