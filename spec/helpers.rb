module Helpers
  module Api
    def parsed_body
      raise 'Response is not a JSON' unless response.content_type == 'application/json'
      JSON.parse body
    end

    def sign_in(user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

    def sign_out
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_call_original
    end
  end
end
