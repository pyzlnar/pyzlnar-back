# A Project contains information on one of the several (online) projects I've worked in.
# Things like blogs, relevant programming exercises etc.
class Project < ApplicationRecord
  JSON_ATTRS = %i(
    code
    name
    status
    url
    start_date
    end_date
    short
    description
    topics
  ).freeze

  validates :name, :start_date, :short, :description,
            presence: true

  validates :code,
            presence:   true,
            uniqueness: true

  validates :status,
            presence:  true,
            inclusion: { in: %w(active stalled dead) }

  validates :topics,
            presence: true,
            array: { may_include: Topic.topics }

  def self.cached(refresh: false)
    Rails.cache.delete(:projects) if refresh
    Rails.cache.fetch(:projects) do
      Project.order(:name).records
    end
  end

  # Converts the object as a json response
  def as_json(*)
    JSON_ATTRS.each_with_object({}) do |attribute, h|
      h[attribute] = public_send(attribute)
    end
  end
end
