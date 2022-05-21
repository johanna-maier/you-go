import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs"

export default class extends Controller {
  static targets = [ "form", "list" ]

  connect() {
    // console.log('insert-review-controller connected!');
  }

  sendReview(event) {
    event.preventDefault();
    const url = this.formTarget.action;
    // console.log(url);

    fetch(url, {
      method: "POST",
      headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() },
      body: new FormData(this.formTarget)
    })
    .then(response => response.json())
    .then((data) => {
      console.log(data);
      if (data.review) { // if review was added successfully
        this.listTarget.insertAdjacentHTML("beforeend", data.review)
      }
      // replace form (new or prev one with errors).  Impotant! replacing parent div
      this.formTarget.parentElement.outerHTML = data.form
    });
  }
}
