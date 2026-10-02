class Task < ApplicationRecord
  belongs_to :user
  belongs_to :project

  STATUSES = %w[todo in_progress review done].freeze
  PRIORITIES = %w[low medium high urgent].freeze

  validates :title, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :priority, inclusion: { in: PRIORITIES }

  before_validation :set_defaults

  private

  def set_defaults
    self.status ||= "todo"
    self.priority ||= "medium"
  end
end
