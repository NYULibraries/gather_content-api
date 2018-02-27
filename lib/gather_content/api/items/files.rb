module GatherContent
  module Api
    module Items
      class Files < Base
        attr_accessor :item_id

        def initialize(item_id)
          raise ArgumentError, "item_id is required!" if item_id.nil?
          @item_id = item_id
        end

        def to_a(statuses = [])
          JSON.parse(get.body)['data'].each do |file|
            new_files = files_class.new(item_id, file['id'])
            files << new_files
          end
          return statuses
        end

        def each(&block)
          self.to_a.each(&block)
        end

      protected

        def files_class
          @files_class ||= Kernel.const_get("GatherContent::Api::Items::File")
        end

      private

        def path
          @path ||= "/items/#{item_id}/files"
        end

        def params; end
      end
    end
  end
end
