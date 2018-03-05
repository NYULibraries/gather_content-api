module GatherContent
  module Error
    class RequestError < StandardError
      attr_reader :response, :status

      def initialize(response)
        @response = response
        @status = response.status

        super(parse_message(response))
      end

    private
      def parse_message(response)
        parsed = JSON.parse(response.body)

        return response.body unless parsed.is_a?(Hash)
        return parsed['data'].join(' ') if parsed['data'].is_a?(Array)

        if parsed.is_a?(Hash) && parsed['data']
          data = parsed['data']

          return data['message'] if data['message']
          return data.to_s
        elsif parsed.is_a?(Hash) && parsed['error']
          parsed['error']
        else
          parsed['data'].to_s
        end
      end
    end
  end
end
