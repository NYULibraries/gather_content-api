require 'gather_content/config/elements/base'

module GatherContent
  module Config
    module Element
      class Text < Base
        attr_accessor :value, :limit_type, :limit, :plain_text

        def initialize(name = "", required = false, label = "", microcopy = "", value = "", limit_type = :chars, limit = 0, plain_text = true)
          super(name, required, label, microcopy)
          @value = value
          @limit_type = limit_type
          @limit = limit
          @plain_text = plain_text
        end

        def serialize(options = nil)
          raise ArgumentError, "limit_type is can only be :words or :chars" unless [ :words, :chars ].include?(limit_type)
          raise ArgumentError, "limit be a positive number" if limit.to_i < 0

          super.merge({
            type: 'text',
            value: value,
            limit_type: limit_type.to_s,
            limit: limit.to_i,
            plain_text: !!plain_text
          })
        end
      end
    end
  end
end
