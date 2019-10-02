class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: [:user, :admin]
  has_attached_file :picture, styles: { medium: "150x150>", small: "50x50>", thumb: "25x25>" }, default_url: "/assets/:style/smile.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
  validates :name, uniqueness: true, presence: true
  validates :email, uniqueness: true
end
