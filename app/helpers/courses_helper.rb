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

end
