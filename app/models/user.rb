# app/models/user.rb
class User < ApplicationRecord
  has_secure_password

  has_many :projects, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :activities, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end
