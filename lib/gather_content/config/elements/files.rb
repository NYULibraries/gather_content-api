require 'gather_content/config/elements/base'

module GatherContent
  module Config
    module Element
      class Files < Base
        attr_accessor :options

        def serialize(options = nil)
          super.merge({
            type: 'files'
          })
        end
      end
    end
  end
end
