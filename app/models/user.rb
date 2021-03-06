require 'digest'

class User < ApplicationRecord

  before_create :encrypt_password

  has_many :courses, dependent: :destroy
  has_many :orders
  has_one :api_access_token

  validates :username, presence: { message: "帳號必填" }, 
                       uniqueness: { message: "該帳號已有人使用" }

  validates :email, presence: { message: "Email必填" }, 
                    uniqueness: { message: "此Email已註冊" }, 
                    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Email格式錯誤，請修正" }

  validates :password, presence: { message: "密碼必填" },
                       length: { in: 6..20, message: "密碼必須在6~20字元" },
                       confirmation: { message: "密碼不吻合" }

  validates :password_confirmation, presence: { message: "請重複輸入密碼" } 

  def can_buy_again?(course_id)
    orders = self.orders.select(:course_id, :valid_until)
    evidence = 0

    orders.each do |order|
      if order.course_id == course_id && order.valid_until > Time.current
        evidence += 1
      end
    end
    
    evidence == 0 ? true : false
  end

  private

  def encrypt_password
    salted_password = "xyz#{self.password.reverse}snaplearn123"
    self.password = Digest::SHA1.hexdigest(salted_password)
  end

  def self.login(login_info)

    username = login_info[:username]
    password = login_info[:password]
    salted_password = "xyz#{password.reverse}snaplearn123"
    encrypted_password = Digest::SHA1.hexdigest(salted_password)

    User.find_by(username: username, password: encrypted_password)
    
  end

end
