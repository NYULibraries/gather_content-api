module GatherContent
  module Api
    module Projects
      class Statuses < Base
        attr_accessor :project_id

        def initialize(project_id)
          raise ArgumentError, "project_id is required!" if project_id.nil?
          @project_id = project_id
        end

        def to_a(statuses = [])
          JSON.parse(get.body)['data'].each do |account|
            new_status = status_class.new(project_id, status['id'])
            statuses << new_status
          end
          return statuses
        end

        def each(&block)
          self.to_a.each(&block)
        end

      protected

        def status_class
          @status_class ||= Kernel.const_get("GatherContent::Api::Projects::Status")
        end

      private

        def path
          @path ||= "/projects/#{project_id}/statuses"
        end

        def params; end
      end
    end
  end
end
