require 'gather_content/config/elements/files'

module GatherContent
  module DSL
    class Base
      def initialize(tab, child)
        @child = child
        tab.elements << @child
      end

      def name(name)
        @child.name = name
      end

      def label(label)
        @child.label = label
      end

      def required(required)
        @child.required = required
      end

      def microcopy(microcopy)
        @child.microcopy = microcopy
      end
    end
  end
end
