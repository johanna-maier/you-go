import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["form"];

  connect() {
    console.log('edit_profile-controller connected!');
  }

  show(){
    // console.log("show form");
    this.formTarget.classList.toggle("d-none");
  }
}
