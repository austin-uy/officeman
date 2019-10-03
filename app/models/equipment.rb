class Equipment < ApplicationRecord
  enum status: [:deployed, :stored, :defective]
  enum equipment_type: [:hardware, :software, :peripheral]
  belongs_to :user
  validates :name, presence: true
  validates :equipment_type, presence: true
  validates :status, presence: true
end
