# A Project contains information on one of the several (online) projects I've worked in.
# Things like blogs, relevant programming exercises etc.
class Project < ApplicationRecord
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
end
