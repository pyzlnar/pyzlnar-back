require 'rails_helper'

describe User do
  context '#admin?' do
    it 'returns true if user is an admin' do
      expect(build(:user).admin?).to_not be
      expect(build(:admin).admin?).to be
    end
  end

  context '#as_json' do
    it 'returns a hash ready to be converted to a public json' do
      user = build(:user)
      expected = {
        username:  user.username,
        email:     user.email,
        thumbnail: user.thumbnail
      }

      expect(user.as_json).to eq expected
    end
  end
end
