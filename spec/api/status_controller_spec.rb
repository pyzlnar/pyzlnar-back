require 'rails_helper'

describe StatusController do
  context '#index' do
    it 'returns a no content response' do
      get '/api/status'

      expect(status).to eq 204
      expect(body).to be_empty
    end
  end
end
