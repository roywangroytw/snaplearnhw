class ApplicationController < ActionController::Base

  include UsersHelper
  include CoursesHelper

  rescue_from ActiveRecord::RecordNotFound, with: :result_not_found

  private

  def result_not_found
    render file: 'public/404.html', layout: false, status: 404
  end

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
