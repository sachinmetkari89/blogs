class Category < ApplicationRecord

  # Validations
  validates :name, presence: true

  # Associations
  has_many :articles, inverse_of: :category, dependent: :restrict_with_exception
end
