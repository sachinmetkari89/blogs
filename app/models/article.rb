class Article < ApplicationRecord
  include AASM

  # Constants
  DRAFT = "draft".freeze
  PUBLISHED = "published".freeze
  ARCHIVED = "archived".freeze

  # Validations
  validates :title, :category, :user, presence: true

  # Associations
  belongs_to :user
  belongs_to :category, inverse_of: :articles

  # State Machin
  aasm column: :state do
    state :draft, initial: true
    state :published
    state :archived

    event :publish do
      transitions from: :draft, to: :published
    end

    event :archive do
      transitions from: :published, to: :draft
    end
  end

end
