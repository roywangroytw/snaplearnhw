export function renderData(api_response) {

  const resultdiv = document.querySelector(".mycourses_row")
  api_response.forEach((course) => {

    const messagediv = document.createElement("div")
    let { name, slug, orders } = course
    let { order_number, currency, amount, payment_type, paytime, valid_until } = orders
  
    const status = determineCourseStatus(valid_until)
    const currency_sign = determineCurrency(currency)
    const paytime_date = convertDate(paytime)
    const expiration_date = convertDate(valid_until)
    messagediv.classList.add("mycourses_item", "col-12", "col-md-6", "col-lg-4")

    messagediv.innerHTML =
    `
    <div class="content_box">
      <div class="mycourses_item_title">
        <h3>${name}</h3>
        <p>${status}</p>
      </div>
      <div class="mycourses_item_details">
        <p><span>單號:</span> ${order_number}</p>
        <p><span>金額:</span> <span>${currency_sign}</span>${amount}</p>
        <p><span>付款方式:</span> ${payment_type}</p>
        <p><span>付款時間:</span> ${paytime_date}</p>
        <p><span>課程過期日期:</span> ${expiration_date}</p>
      </div>
      <div class="mycourses_item_link">
        <a href="http://localhost:3000/courses/${slug}">前往課程頁</a>
      </div>
    </div>

    `
    resultdiv.appendChild(messagediv)

  })

}

function determineCourseStatus(valid_until) {
  const today = new Date().toISOString().slice(0, 10)

  if (valid_until > today) {
    const valid_until = "開放中"
    return valid_until 
  } else {
    const valid_until = "已過期"
    return valid_until 
  }
}

function determineCurrency(currency) {
  if (currency === "TWD") {
    const sign = "新台幣(NT$)"
    return sign
  } else if (currency === "USD") {
    const sign = "美金($)"
    return sign
  } else if (currency === "GBP") {
    const sign = "英鎊(£)"
    return sign
  } else if (currency === "EUR") {
    const sign = "歐元(€)"
    return sign
  } else if (currency === "SGD") {
    const sign = "新加坡幣(SG$)"
    return sign
  } else {
    const sign = "日幣(¥)"
    return sign
  }
}

function convertDate(paytime) {
  const date = new Date(paytime)
  const formatted_date = date.getFullYear() + "/" + (date.getMonth()+1) + "/" + date.getDate()
  return formatted_date
}

