require 'gather_content/dsl/config'

module GatherContent
  module Config
    class Builder
      attr_accessor :tabs

      def initialize
        self.tabs = []
      end

      def self.build(&block)
        instance = self.new
        dsl = GatherContent::DSL::Config.new(instance)
        dsl.instance_eval(&block)
        instance.tabs
      end
    end
  end
end
