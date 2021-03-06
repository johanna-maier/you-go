import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["tab", "details"];

  connect() {
    console.log('tabs-controller connected!');
    // console.log(this.detailsTargets);
  }

  showTab(event){
    // console.log(event.currentTarget)
    // console.log(`show tab ${event.currentTarget.dataset.link}`);
    this.hideAll();
    this.show(event.currentTarget.dataset.link);
  }


  show(tab_name) {
    // console.log(this.element.querySelector(`#${tab_name}`));
    const tabElement = this.element.querySelector(`#${tab_name}`);
    tabElement.classList.remove('d-none');

    //
    if(tab_name == 'wishlist') {
      if(this.element.querySelector('#wishlist-card')) // check if wishlist item exists
        this.element.querySelector('#wishlist-card').click()
    }else if(tab_name == 'bookings') {
      if(this.element.querySelector('#booking-card'))
        this.element.querySelector('#booking-card').click()
    }
  }

  disconnect(){
    this.hideAll();
  }

  hideAll() {
    this.tabTargets.forEach((element) => {
      element.classList.add('d-none');
    });
    // to remove the details card on wishlist and bookings screen
    this.detailsTargets.forEach((element) => {
      element.classList.add('d-none');
    });
  }
}
