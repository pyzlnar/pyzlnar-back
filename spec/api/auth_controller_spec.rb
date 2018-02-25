require 'rails_helper'

describe AuthController do
  let(:controller) { AuthController }

  context 'POST #login' do
    it 'returns 201 and an user if it was able to login' do
      user  = build(:user)
      login = double(success?: true, user: user)

      expect(Auth::GoogleLoginCommand).to receive(:call).with(token: 'token').and_return(login)
      expect_any_instance_of(controller).to receive(:sign_in).with(user)
      expect_any_instance_of(controller).to receive(:form_authenticity_token).and_return(:csrf_token)

      post '/api/auth/login', params: { google: { id_token: :token } }

      expected = { user: user, token: :csrf_token }.to_json

      expect(status).to eq 201
      expect(body).to eq expected
    end

    it 'returns 422 if missing the needed parameters to login' do
      post '/api/auth/login'
      expect(status).to eq 422
      expect(body).to be_blank
    end

    it 'returns a 401 if unable to do a sign in' do
      login = double(success?: false)

      expect(Auth::GoogleLoginCommand).to receive(:call).and_return(login)
      expect_any_instance_of(controller).to_not receive(:sign_in)

      post '/api/auth/login', params: { google: { id_token: :token } }

      expect(status).to eq 401
      expect(body).to be_blank
    end
  end

  context 'DELETE #logout' do
    it 'signs out the user' do
      expect_any_instance_of(controller).to receive(:sign_out)
      delete '/api/auth/logout'
    end
  end
end
