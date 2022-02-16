class Course < ApplicationRecord
  has_many :course_categories, dependent: :delete_all
  has_many :categories, through: :course_categories  #雖然說我前端目前只給使用者選一種category, 但考慮到未來可能會擴充變成多對多，所以就先這麼做了
  has_many :orders

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

  private

  def self.filter_courses(status, course_types, user_id)
    today = DateTime.now

    if course_types.length != 0
      if status == "Active"
        courses = Course.joins(:orders).joins(:categories).where('orders.user_id = ? AND orders.valid_until >= ? AND categories.id in (?)', user_id, today, course_types).select("*")
        return courses
      elsif status == "Expired"
        courses = Course.joins(:orders).joins(:categories).where('orders.user_id = ? AND orders.valid_until < ? AND categories.id in (?)', user_id, today, course_types).select("*")
        return courses
      elsif status == ""
        courses = Course.joins(:orders).joins(:categories).where('orders.user_id = ? AND categories.id in (?)', user_id, course_types).select("*")
        return courses
      end
    else
      if status == "Active"
        courses = Course.joins(:orders).joins(:categories).where('orders.user_id = ? AND orders.valid_until >= ?', user_id, today).select("*")
        return courses
      elsif status == "Expired"
        courses = Course.joins(:orders).joins(:categories).where('orders.user_id = ? AND orders.valid_until < ?', user_id, today).select("*")
        return courses
      end
    end 
  end
  
end
