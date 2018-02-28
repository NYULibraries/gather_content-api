module GatherContent
  module Api
    class Items < Base
      include Enumerable
      attr_accessor :project_id

      def initialize(project_id)
        raise ArgumentError, "Project_id is required!" if project_id.nil?
        @project_id = project_id
      end

      def each(&block)
        fetch.each do |item|
          yield GatherContent::Api::Item.new(item['id'], item)
        end
      end

      def create(data)
        data.delete("parent_id") if data["parent_id"].nil? || data["parent_id"].empty?
        data.delete("template_id") if data["template_id"].nil? || data["template_id"].empty?
        data.delete("config") if data["config"].nil? || data["config"].empty?

        raise ArgumentError, "name is required!" if data["name"].nil? || data["name"].empty?

        result = post_json(data.merge({ 'project_id' => @project_id }))

        if result.status == 202
          item_id = result.headers['location'].split('/').last
          GatherContent::Api::Item.new(item_id)
        else
          raise GatherContent::Error::RequestError.new(result)
        end
      end

    private
      def params
        { project_id: project_id }
      end

      def path
        @path ||= '/items'
      end

    end
  end
end
