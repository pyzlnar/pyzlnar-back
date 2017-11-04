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

  context 'PATCH #update' do
    it 'returns updated information of the current user if the update was successful' do
      user = create(:user)
      sign_in(user)

      params = { user: { username: 'NewName' } }
      patch '/api/me', params: params

      expect(status).to eq 200
      expect(parsed_body['username']).to eq 'NewName'
    end

    it 'returns the information of the current user if nothing was changed' do
      user = create(:user)
      sign_in(user)

      patch '/api/me'

      expect(status).to eq 200
      expect(body).to eq user.to_json
    end

    it 'returns 422 if something went wrong' do
      user = create(:user)
      sign_in(user)
      create(:admin)

      expected = { username: ['has already been taken'] }.to_json
      params   = { user: { username: 'admin' } }
      patch '/api/me', params: params

      expect(status).to eq 422
      expect(body).to eq expected
    end
  end
end
