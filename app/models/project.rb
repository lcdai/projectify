class Project < ApplicationRecord
  belongs_to :user

  has_many :tasks, dependent: :destroy
  has_many :activities, dependent: :destroy

  STATUSES = %w[planning active completed archived].freeze

  validates :name, presence: true
  validates :status, inclusion: { in: STATUSES }

  before_validation :set_default_status
  after_create :log_created

  private

  def set_default_status
    self.status ||= "planning"
  end

  def log_created
    activities.create!(
      user: user,
      action: "project_created",
      details: "Created project #{name}"
    )
  end
end
