module GatherContent
  module Config
    module Element
      class Option
        attr_accessor :name, :label, :selected

        def initialize(name = nil, label = nil, selected = nil)
          @name = name
          @label = label
          @selected = selected
        end

        def serialize(options = nil)
          raise ArgumentError, "name is required" unless name.present?
          raise ArgumentError, "label is required" unless label.present?

          {
            name: name,
            label: label,
            selected: !!selected
          }
        end

        def to_json(options = nil)
          serialize.to_json(options)
        end
      end
    end
  end
end
