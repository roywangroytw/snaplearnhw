class Course < ApplicationRecord
  has_many :course_categories, dependent: :delete_all
  has_many :categories, through: :course_categories

  extend FriendlyId
  friendly_id :personalized_prefix, use: :slugged

  validates :name, presence: { message: "課程名稱必填"}
  validates :price, presence: { message: "價格必填"}, numericality: { greater_than: 0 }
  validates :currency, presence: { message: "幣別必選"}
  validates :introduction, presence: { message: "別忘了課程介紹"}
  validates :status, presence: { message: "課程狀態必選"}
  validates :validity_duration, presence: { message: "課程效期必選"}
  validates :personalized_prefix, presence: { message: "請給填寫一個客製化名稱" }, 
                                  uniqueness: true,
                                  format: { with: /[a-zA-Z0-9]/, message: "只能包含英文字母與數字"}
end
