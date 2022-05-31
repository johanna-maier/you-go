import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["details"];

  connect() {
    console.log('show_offer-controller connected!');
  }

  show(){
    // console.log("show form");
    this.detailsTarget.classList.remove("d-none");
  }
}
