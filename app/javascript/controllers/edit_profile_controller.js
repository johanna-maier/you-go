import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["form", "card", "prefs"];

  connect() {
    console.log('edit_profile-controller connected!');
  }

  show(){
    // console.log("show form");
    this.formTarget.classList.toggle("d-none");

    // ----for testing
    // // console.log(this.prefsTarget);
    // const prefs = []
    // this.cardTargets.forEach((element) => {
    //   if(element.classList.contains('active')) {
    //     // console.log(element.id);
    //     prefs.push(element.id);
    //   }

    // });
    // console.log(prefs);
    // console.log(this.prefsTarget.value)
    // this.prefsTarget.value = prefs;
    // //------
  }

  send(event){
    console.log("submit form");

    //save user prefs
    const prefs = [];
    this.cardTargets.forEach((element) => {
      if(element.classList.contains('active')) {
        prefs.push(element.id);
      }
    });
    // console.log(prefs);
    this.prefsTarget.value = prefs;

    // hide form and continue with default action
    this.formTarget.classList.add("d-none");
  }

  // for sports category selection
  toggleActiveClass(event) {
    event.currentTarget.classList.toggle('active');
  };
}
