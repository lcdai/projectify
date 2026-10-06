class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :task, optional: true

  validates :action, presence: true
end
