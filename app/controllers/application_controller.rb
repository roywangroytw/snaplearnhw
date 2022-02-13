class ApplicationController < ActionController::Base

  include UsersHelper
  include CoursesHelper

  private

  def authenticate_admin
    if not user_is_login?
      redirect_to login_path, notice: "請先登入"
    elsif not user_is_admin?
      redirect_to courses_path, notice: "您的身份無法管理/新增/編輯課程"
    end  
  end

  def authenticate_user
    if not user_is_login?
      redirect_to login_path, notice: "請先登入"
    end
  end

end
