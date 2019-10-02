class Equipment < ApplicationRecord
  enum status: [:deployed, :stored, :defective]
  enum equipment_type: [:hardware, :software, :peripheral]
  belongs_to :user
  validates :name, presence: true
end
