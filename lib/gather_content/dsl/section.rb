require 'gather_content/config/elements/section'

module GatherContent
  module DSL
    class Section
      def initialize(tab)
        @section = GatherContent::Config::Element::Section.new
        tab.elements << @section
      end

      def name(name)
        @section.name = name
      end

      def title(title)
        @section.title = title
      end

      def subtitle(subtitle)
        @section.subtitle = subtitle
      end
    end
  end
end
