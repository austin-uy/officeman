class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  enum role: %i[user admin]
  has_attached_file :picture, styles: {
    medium: '150x150>', small: '50x50>', thumb: '25x25>'
  }, default_url: '/images/:style/smile.png'
  validates_attachment_content_type :picture, content_type: %r{\Aimage/.*\z}
  validates :password, confirmation: true
  validates :name, presence: true
  validates :email, uniqueness: true
  has_many :equipment, dependent: :destroy
  has_many :answers, dependent: :destroy
end
