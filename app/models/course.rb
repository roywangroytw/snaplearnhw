class Course < ApplicationRecord
  has_many :course_categories
  has_many :categories, through: :course_categories

  extend FriendlyId
  friendly_id :personalized_prefix, use: :slugged
end
