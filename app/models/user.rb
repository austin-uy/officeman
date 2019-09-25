class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: [:user, :admin]
  has_attached_file :picture, styles: { medium: "250x250>", thumb: "50x50>" }, default_url: "/images/lorem.jpg"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
end
