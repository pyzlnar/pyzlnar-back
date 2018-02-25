require 'rails_helper'

describe Auth::ControllerHelpers do
  let(:includer) do
    Class.new do
      include Auth::ControllerHelpers
      attr_accessor :session
      define_method :render, ->(*args){}
    end.new
  end

  before do
    includer.session = {}
    includer.current_user = nil
  end

  it 'defines accessors for #current_user' do
    expect(includer).to respond_to(:current_user)
    expect(includer).to respond_to(:current_user=)
  end

  context '#authenticate_user' do
    it 'sets the current_user by the uuid set in the session' do
      user = create(:user)
      includer.session[:sub] = user.uuid
      includer.authenticate_user

      expect(includer.current_user).to eq user
    end

    it 'sets nothing if no session or cant find user' do
      includer.authenticate_user
      expect(includer.current_user).to be_nil

      includer.session[:sub] = SecureRandom.uuid
      includer.authenticate_user
      expect(includer.current_user).to be_nil
    end
  end

  context '#authenticate_user!' do
    it 'does nothing if user is authenticated' do
      includer.current_user = build(:user)
      expect(includer).to_not receive(:render)

      includer.authenticate_user!
    end

    it 'renders a 401 if user is not authenticated' do
      expect(includer).to receive(:render).with(status: 401)
      includer.authenticate_user!
    end
  end

  context '#authorize_user' do
    it 'returns true if user is authorized' do
      includer.current_user = build(:admin)
      expect(includer.authorize_user).to be
    end

    it 'returns false if user is not authorized' do
      expect(includer.authorize_user).to_not be

      includer.current_user = build(:user)
      expect(includer.authorize_user).to_not be
    end
  end

  context '#authorize_user!' do
    it 'does nothing if user is authorized' do
      includer.current_user = build(:admin)
      expect(includer).to_not receive(:render)

      includer.authorize_user!
    end

    it 'renders a 403 is user is not authorized' do
      expect(includer).to receive(:render).with(status: 403)
      includer.authorize_user!
    end
  end

  context '#sign_in' do
    it 'sets the current_user in class and session' do
      user = build(:user)
      includer.sign_in(user)

      expect(includer.current_user).to eq user
      expect(includer.session[:sub]).to eq user.uuid
    end
  end

  context '#sign_out' do
    it 'unsets the current_user in class and session' do
      includer.sign_in(build(:user))
      includer.sign_out

      expect(includer.current_user).to be_nil
      expect(includer.session[:sub]).to be_nil
    end
  end

  context '#user_signed_in?' do
    it 'asks if the user is signed in' do
      expect(includer.user_signed_in?).to_not be
      includer.sign_in(build(:user))
      expect(includer.user_signed_in?).to be
    end
  end
end
