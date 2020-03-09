class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 #Constants
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

 # Validation
  validates :name, presence: true
  validates :mobile, presence: true, uniqueness: true, numericality: true, length: { is: 10 }
  validates_format_of :mobile, with: /\d[0-9]\)*\z/
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }, allow_nil: true
  
  # Associations
  has_many :articles

end
