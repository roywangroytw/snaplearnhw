import { Controller } from "stimulus"
import { renderData } from "../packs/mycourses"
import { getCookie } from "../packs/retrievetoken"

export default class extends Controller {
  static targets = [ "coursediv" ]

  connect(){

    const key = getCookie("snapToken")
    
    async function fetch_api() {
      try {
        const csrfToken = document.querySelector("[name='csrf-token']").content
        const response = await fetch(`/api/v0/mycourses?access_key=${key}`, {
          method: "GET",
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
      const api_response = await fetch_api()
      
      if (api_response.length !== 0) {
        renderData(api_response)
      } else {
        const messagediv = document.createElement("div")
        messagediv.innerText = "目前您尚未購買過任何課程"
        resultdiv.appendChild(messagediv)
      }
    }
    
    processingApiCall();

  }

  filterCourse(e) {

    e.preventDefault()
    const data = Object.fromEntries(new FormData(document.querySelector('.filter_form')).entries());
    const keys = Object.keys(data)
    const course_types = processType(keys)
    const status = data.status
    const key = getCookie("snapToken")

    async function fetch_filter_api() {
      try {
        const csrfToken = document.querySelector("[name='csrf-token']").content
        const response = await fetch(`/api/v0/mycourses/filter?access_key=${key}&status=${status}&course_types=${course_types}`, {
          method: "GET",
          headers: {
            "X-CSRF-Token": csrfToken
          }
        })
        const result = await response.json()
        return result
      }
      catch {
        console.error("Something went wrong...");
      }
    }

    async function processApiCall() {
      const api_response = await fetch_filter_api()

      console.log(api_response);

      if (api_response.length !== 0) {
        const resultdiv = document.querySelector(".mycourses_row")
        resultdiv.innerHTML = ""
        renderData(api_response)
      } else {
        const messagediv = document.createElement("div")
        const resultdiv = document.querySelector(".mycourses_row")
        resultdiv.innerHTML = ""
        messagediv.innerText = "沒有符合篩選條件的課程"
        resultdiv.appendChild(messagediv)
      }
    }

    processApiCall()

    function processType(keys) {
      const values = []
      keys.forEach((key)=>{
         if (key.includes("course_type_")) {
          values.push(parseInt(data[key]))
        }
      })
      return values
    }

  }

  removeFilters(e){
    e.preventDefault()
    location.reload()
  }
}