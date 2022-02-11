class User < ApplicationRecord

  validates :username, presence: { message: "帳號必填" }, 
                       uniqueness: { message: "該帳號已有人使用" }

  validates :email, presence: { message: "Email必填" }, 
                    uniqueness: { message: "此Email已註冊" }, 
                    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Email格式錯誤，請修正" }

  validates :password, presence: { message: "密碼必填" },
                       length: { in: 6..20, message: "密碼必須在6~20字元" },
                       confirmation: { message: "密碼不吻合" }

  validates :password_confirmation, presence: { message: "請重複輸入密碼" } 

end
