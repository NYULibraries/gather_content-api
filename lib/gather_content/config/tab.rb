module GatherContent
  module Config
    class Tab
      attr_accessor :label, :name, :hidden, :elements

      def initialize(label = "", name = "", hidden = false, elements = [])
        self.label = label
        self.name = name
        self.hidden = hidden
        self.elements = elements
      end

      def serialize(options = nil)
        raise ArgumentError, "name is required" unless name.present?
        raise ArgumentError, "label is required" unless label.present?

        {
          label: label,
          name: name,
          hidden: !!hidden,
          elements: elements.map{ |el| el.serialize(options) }
        }
      end

      def to_json(options = nil)
        serialize.to_json(options)
      end
    end
  end
end
