# An user... well you should really know what an user is.
class User < ApplicationRecord
  validates :uuid,
            presence:   true,
            uniqueness: true

  validates :username,
            presence:   true,
            uniqueness: true

  validates :email,
            presence:   true,
            uniqueness: true,
            format: { with: /@/ }

  # Quick method to verify user role
  def admin?
    role == 'admin'
  end

  # Converts the user to a json response
  def as_json(*)
    %i[username email thumbnail].each_with_object({}) do |attribute, h|
      h[attribute] = public_send(attribute)
    end
  end
end
