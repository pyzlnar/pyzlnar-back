module Helpers
  module Api
    def parsed_body
      raise 'Response is not a JSON' unless response.content_type == 'application/json'
      JSON.parse body
    end
  end
end
