class Task < ApplicationRecord
  belongs_to :user
  belongs_to :project

  STATUSES = %w[todo in_progress review done].freeze
  PRIORITIES = %w[low medium high urgent].freeze

  validates :title, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :priority, inclusion: { in: PRIORITIES }

  before_validation :set_defaults
  after_create :log_created
  after_update :log_updated

  private

  def set_defaults
    self.status ||= "todo"
    self.priority ||= "medium"
  end

  def log_created
    Activity.create!(
      user: user,
      project: project,
      task: self,
      action: "task_created",
      details: "Created task #{title}"
    )
  end

  def log_updated
    Activity.create!(
      user: user,
      project: project,
      task: self,
      action: "task_updated",
      details: "Updated task #{title}"
    )
  end
end
