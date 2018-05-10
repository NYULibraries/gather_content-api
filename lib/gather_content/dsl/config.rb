require 'gather_content/dsl/tab'

module GatherContent
  module DSL
    class Config
      def initialize(config)
        @config = config
      end

      def tab(&block)
        dsl = GatherContent::DSL::Tab.new(@config)
        dsl.instance_eval(&block)
      end
    end
  end
end
