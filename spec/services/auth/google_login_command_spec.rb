require 'rails_helper'

describe Auth::GoogleLoginCommand do
  let(:command){ Auth::GoogleLoginCommand }
  let(:validator){ GoogleIDToken::Validator }

  context '#call' do
    it 'fails if it receives an invalid token' do
      allow_any_instance_of(validator).to receive(:check).and_raise(GoogleIDToken::ValidationError)
      result = command.call(token: :token)

      expect(result.status).to eq :invalid_token
      expect(result.success?).to_not be
    end

    it 'fails if the email has not been verified' do
      validation = { email_verified: false }
      allow_any_instance_of(validator).to receive(:check).and_return(validation)
      result = command.call(token: :token)

      expect(result.status).to eq :unverified_email
      expect(result.success?).to_not be
    end

    it 'creates a new user if it cant be found' do
      user = build(:user)
      validation = {
        email_verified: true,
        sub:            user.sub,
        name:           user.username,
        email:          user.email,
        picture:        user.thumbnail
      }
      allow_any_instance_of(validator).to receive(:check).and_return(validation)
      result = command.call(token: :token)

      expect(result.success?).to be
      expect(result.user).to be_persisted
    end

    it 'returns an already existing user if it exists' do
      user = create(:user)
      validation = {
        email_verified: true,
        sub:            user.sub,
        name:           user.username,
        email:          user.email,
        picture:        user.thumbnail
      }
      allow_any_instance_of(validator).to receive(:check).and_return(validation)
      result = command.call(token: :token)

      expect(result.success?).to be
      expect(result.user).to eq user
    end

    it 'updates an user email if needed' do
      user = create(:user)
      validation = {
        email_verified: true,
        sub:            user.sub,
        name:           user.username,
        email:          'new_email@a.com',
        picture:        user.thumbnail
      }
      allow_any_instance_of(validator).to receive(:check).and_return(validation)
      result = command.call(token: :token)

      expect(result.success?).to be
      expect(result.user).to eq user
      expect(result.user.email).to eq 'new_email@a.com'
    end
  end
end
