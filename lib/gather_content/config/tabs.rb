module GatherContent
  module Config
    class Tabs < Array
      def serialize(options = nil)
        self.map{ |el| el.serialize(options) }
      end

      def to_json(options = nil)
        self.serialize.to_json
      end
    end
  end
end
