// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"
import { getCookie } from "../packs/retrievetoken"

export default class extends Controller {
  static targets = [ "purchasebtn", "paymentselector" ]

  makeOrder() {
    
    const selector = this.paymentselectorTarget
    const paymentType = selector.dataset.type
    const urlString = window.location.href;
    const decomposedUrl = urlString.split("/")
    const id = decomposedUrl[4]
    const key = getCookie("snapToken")

    async function fetch_api() {
      try {
        const csrfToken = document.querySelector("[name='csrf-token']").content
        const response = await fetch(`/api/v0/orders/new?id=${id}&payment_type=${paymentType}&access_key=${key}`, {
          method: "POST",
          headers: {
            "X-CSRF-Token": csrfToken,
          }
        })
        const result = await response.json()
        return result
      }
      catch {
        console.error("Something went wrong...");
      }
    }

    async function processingApiCall() {
      const apiResponse = await fetch_api()
      const paymentErrorDiv = document.querySelector(".flash_message_payment")

      if (apiResponse.status === "success") {

        const loader = document.querySelector(".order_loader")
        loader.classList.add("order_loader_show")

        setTimeout(() => {
          orderSuccess()
        }, 3000)

        function orderSuccess() {
          window.location.replace(`/courses/${id}/ordersuccess`)
        }

      } else if (apiResponse.message === "Something went wrong, please try again") {
        
        const message = document.createElement("p")
        message.innerText = "抱歉，系統出了點問題，請再嘗試一次"
        paymentErrorDiv.appendChild(message)

      } else if (apiResponse.message === "You have purchased this course, and it's still valid") {
        const message = document.createElement("p")
        message.innerText = "您已經購買過此課程，課程有效期尚未結束"
        paymentErrorDiv.appendChild(message)
      }

    }

    processingApiCall()

  }

  capturePaymentType() {
    const selector = this.paymentselectorTarget
    if (selector.value !== "Null") {
      selector.dataset.type = selector.value
    } else {
      delete selector.dataset.type
    }
  }

}
