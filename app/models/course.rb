class Course < ApplicationRecord
  has_many :course_categories
  has_many :categories, through: :course_categories
  
  enum currency: [:TWD, :USD, :SGD, :JPY, :EUR, :GBP]
end
