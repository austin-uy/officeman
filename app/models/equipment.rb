class Equipment < ApplicationRecord
  enum status: %i[deployed stored defective ]
  enum equipment_type: %i[hardware license online\ account peripheral]
  belongs_to :user
  validates :name, presence: true
  validates :equipment_type, presence: true
  validates :status, presence: true
end
