require 'rails_helper'

describe MeController do
  context 'GET #show' do
    it 'returns the information of the current user' do
      user = build(:user)
      sign_in(user)

      get '/api/me'

      expect(status).to eq 200
      expect(body).to eq user.to_json
    end
  end
end
