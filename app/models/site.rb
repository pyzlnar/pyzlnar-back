# A Site contains information of the most relevant internet sites where I have a profile
# Eg: Twitter, Youtube, etc...
class Site < ApplicationRecord
  validates :name, :url, :description,
            presence: true

  validates :code,
            presence:   true,
            uniqueness: true

  validates :status,
            presence:  true,
            inclusion: { in: %w[active inactive] }

  validates :topics,
            presence: true,
            array: { may_include: Topic.topics }

  def self.cached(refresh: false)
    Rails.cache.delete(:sites) if refresh
    Rails.cache.fetch(:sites) do
      Site.order(:status, :name).records
    end
  end

  # Converts the object as a json response
  def as_json(*)
    %i[code name status url description topics].each_with_object({}) do |attribute, h|
      h[attribute] = public_send(attribute)
    end
  end
end
