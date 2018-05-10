require 'gather_content/dsl/base'
require 'gather_content/config/elements/files'

module GatherContent
  module DSL
    class Files < Base
      def initialize(tab)
        super(tab, GatherContent::Config::Element::Files.new)
      end
    end
  end
end
