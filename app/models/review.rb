class Review < ApplicationRecord
  belongs_to :user
  belongs_to :tour
  validates :comment, length: {minimum: 5}
  validates :time, presence: true
end
