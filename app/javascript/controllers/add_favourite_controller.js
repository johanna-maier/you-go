import { Controller } from "stimulus"
import { csrfToken } from "@rails/ujs"

export default class extends Controller {
  static targets = ["heart"];
  static values = { url: String }

  connect() {
    // console.log('add-favourite-controller connected!');
    // console.log (this.heartTarget);
  }

  addHeart(event) {
    event.preventDefault();
    // console.log(this.heartTarget.dataset["url"]);
    const url = this.heartTarget.dataset["url"];
    console.log (`add favorite ${url}`);

    fetch(url, {
      method: "POST",
      headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() }
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data);
        if(data.success == 'true') {
          // 'like' successfully added, show active (red) heart icon
          this.heartTarget.outerHTML = data.icon
        }
      })
  }

  removeHeart(event) {
    event.preventDefault();
    // console.log(this.heartTarget.dataset["url"]);
    const url = this.heartTarget.dataset["url"];
    console.log (`remove favorite ${url}`);

    fetch(url, {
      method: "DELETE",
      headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() }
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data);
        if(data.success == 'true') {
          // 'like' successfully removed, show inactive (grey) heart icon
          this.heartTarget.outerHTML = data.icon
        }
      })
  }


  }
