class Category < ApplicationRecord
  has_many :course_categories
  has_many :courses, through: :course_categories
end
