import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["tab"];

  connect() {
    console.log('tabs-controller connected!');
    // console.log(this.tabTargets);

    if(window.location.hash) {
      // Fragment exists
      console.log('Fragment exists')
      const tab_name = window.location.hash.substring(1); // Puts hash in variable, and removes the # character
      this.show(tab_name)
    }
  }

  showTab(event){
    console.log(event.currentTarget)
    // console.log(`show tab ${event.currentTarget.dataset.link}`);
    this.hideAll();
    this.show(event.currentTarget.dataset.link);
  }


  show(tab_name) {
    // console.log(this.element.querySelector(`#${tab_name}`));
    const tabElement = this.element.querySelector(`#${tab_name}`);
    tabElement.classList.remove('d-none');
    if(tab_name == 'wishlist') {
      document.querySelector('#wishlist-card').click()
    }else if(tab_name == 'bookings') {
      document.querySelector('#booking-card').click()
    }
  }

  disconnect(){
    this.hideAll();
  }

  hideAll() {
    this.tabTargets.forEach((element) => {
      element.classList.add('d-none');
    });
  }
}
