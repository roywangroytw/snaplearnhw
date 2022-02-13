module CoursesHelper

  def currency_sign(currency)
    case currency
    when "TWD"
      "新台幣(NT$)"
    when "USD"
      "美金($)"
    when "GBP"
      "英鎊(£)"
    when "EUR"
      "歐元(€)"
    when "SGD"  
      "新加坡幣(SG$)"
    else
      "日幣(¥)"
    end
  end

  def course_belongs_to_user?(course_id)
    courses_of_users = current_user.courses
    courses_of_users.include?(Course.friendly.find(course_id)) ? true : false
  end

  def user_is_admin?
    if session[:session]
      current_user.course_creator == true ? true : false
    else
      false
    end  
  end

  def course_status(status)
    status == "Offshelf" ? "下架中" : "已上架"
  end

end
