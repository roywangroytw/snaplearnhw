class Course < ApplicationRecord
  has_many :course_categories
  has_many :categories, through: :course_categories

  enum currency: [:TWD, :USD, :SGD, :JPY, :EUR, :GBP]

  extend FriendlyId
  friendly_id :personalized_prefix, use: :slugged
end
