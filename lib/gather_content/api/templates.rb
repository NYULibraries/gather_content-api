module GatherContent
  module Api
    class Templates < Base
      attr_accessor :project_id
      include Enumerable

      def initialize(project_id)
        raise ArgumentError, "project_id is required!" if project_id.nil?
        @project_id = project_id
      end

      def each(&block)
        fetch.each do |template|
          yield GatherContent::Api::Template.new(template['id'], template)
        end
      end

    private

      def params
        { project_id: @project_id }
      end

      def path
        @path ||= '/templates'
      end

      def valid_type?(type)
        return type = "other" if type.nil? || type.empty?
        types = %w{website-build ongoing-website-content marketing-editorial-content email-marketing-content other}
        types.include?(type)
      end
    end
  end
end
