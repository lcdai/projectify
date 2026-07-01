class Project < ApplicationRecord
  belongs_to :user

  has_many :tasks, dependent: :destroy
  has_many :activities, dependent: :destroy

  STATUSES = %w[planning active completed archived].freeze

  validates :name, presence: true
  validates :status, inclusion: { in: STATUSES }

  before_validation :set_default_status

  private

  def set_default_status
    self.status ||= "planning"
  end
end
