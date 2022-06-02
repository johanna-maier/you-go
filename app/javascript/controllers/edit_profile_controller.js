import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["form", "card", "prefs"];

  connect() {
    console.log('edit_profile-controller connected!');
  }

  show(){
    // console.log("show form");
    this.formTarget.classList.toggle("d-none");

    // ----temp
    console.log(this.prefsTarget);
    const prefs = []
    this.cardTargets.forEach((element) => {
      if(element.classList.contains('active')) {
        console.log(element.id);
        prefs.push(element.id);
      }

    });
    console.log(prefs);
    //------
  }

  send(){
    console.log("submit form");
    this.formTarget.classList.add("d-none");

    //save user prefs
    const prefs = [];
    this.cardTargets.forEach((element) => {
      if(element.classList.contains('active')) {
        console.log(element.id)
        prefs.push(element.id)
      }
    });
    console.log(prefs);
    // do default action
  }

  // for sports category selection
  toggleActiveClass(event) {
    console.log(`clicked... ${event.currentTarget}`);
    event.currentTarget.classList.toggle('active');
  };
}
