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
            inclusion: { in: %w(active inactive) }

  validates :topics,
            presence: true,
            array: { may_include: Topic.topics }
end
