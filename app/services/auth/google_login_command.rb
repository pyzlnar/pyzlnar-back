# This command
# 1. Recieves an id_token
# 2. Validates the token is authentic and has not expired
# 3. Parses the token into a hash
# 4. Finds or creates a new user with said info
class Auth::GoogleLoginCommand
  include AyeCommander::Command

  APP_ID = Rails.application.secrets.dig(:omniauth, :id).freeze

  requires :token

  def call
    parse_token
    verify_email
    find_user
    abort! unless needs_saving?
    arrange_data
    save_user
  end

  private

  def app_id
    APP_ID
  end

  def needs_saving?
    user.new_record? || user.email != payload[:email]
  end

  def parse_token
    validator = GoogleIDToken::Validator.new
    payload   = validator.check(token, app_id, app_id)
    @payload  = payload.symbolize_keys
  rescue GoogleIDToken::ValidationError => e
    @error = e
    fail!(:invalid_token) && abort!
  end

  def find_user
    @user = User.find_by(sub: payload[:sub]) || User.new
  end

  def verify_email
    return if payload[:email_verified]
    @error = 'Email has not been verified!'
    fail!(:unverified_email) && abort!
  end

  def arrange_data
    @user_params = {
      uuid:      SecureRandom.uuid,
      sub:       payload[:sub],
      username:  payload[:name],
      email:     payload[:email],
      thumbnail: payload[:picture]
    }
    @user_params.slice!(:email) if user.persisted?
  end

  def save_user
    user.assign_attributes(user_params)
    user.save!
  rescue ActiveRecord::RecordInvalid => e
    @error = e
    fail!(:invalid_record) && abort!
  end
end
