module GatherContent
  module Config
    module Element
      class Section
        attr_accessor :name, :title, :subtitle

        def initialize(name = "", title = "", subtitle = "")
          @name = name
          @title = title
          @subtitle = subtitle
        end

        def serialize(options = nil)
          raise ArgumentError, "name is required" unless name.present?
          raise ArgumentError, "title is required" unless title.present?

          {
            type: "section",
            name: name,
            title: title,
            subtitle: subtitle
          }
        end

        def to_json(options = nil)
          serialize.to_json(options)
        end
      end
    end
  end
end
