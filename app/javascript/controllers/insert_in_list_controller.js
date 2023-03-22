import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="insert-in-list"
export default class extends Controller {

  static targets = ["items"]
  connect() {
    console.log(this.element)
    console.log(this.itemsTarget)
  }

  submit(event) {
    event.preventDefault()
    console.log("Hey, send the request in AJAX")
    const form = event.target
    const url = form.action
    console.log(form.method)
    console.log(url)
    console.log(form)
    fetch(url, {
      method: form.method,
      headers: {"Accept": "application/json"},
      body: new FormData(form)
    })
      .then(response => response.json())
      .then((data) => {
          console.log(data)
          console.log(data.review_html)
          if (data.review_html) {
            this.itemsTarget.insertAdjacentHTML('afterBegin', data.review_html)
          }
          form.outerHTML = data.form_html
        })
  }
}
