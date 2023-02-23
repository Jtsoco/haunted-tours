import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="booking"
export default class extends Controller {
  static targets = ["price"]

  connect() {
    console.log(parseInt(this.priceTarget.innerText.substring(1), 10))
  }
  updatePrice(event) {
    console.log(this.priceTarget.dataset.value)
    const dynamicPrice = event.currentTarget.value * parseInt(this.priceTarget.dataset.value, 10)
    this.priceTarget.innerText = dynamicPrice
  }
}
