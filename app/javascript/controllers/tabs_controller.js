import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["profile", "booking", "wishlist", "conversations"];

  connect() {
    console.log('tabs-controller connected!');
  }

  showTab(event) {
    // console.log(event);
  }

  showWishlist() {
      this.wishlistTarget.classList.remove('d-none')
      this.profileTarget.classList.add('d-none')
      this.bookingTarget.classList.add('d-none')
      this.conversationsTarget.classList.add('d-none')
  }

  showBookings() {
    this.wishlistTarget.classList.add('d-none')
    this.profileTarget.classList.add('d-none')
    this.bookingTarget.classList.remove('d-none')
    this.conversationsTarget.classList.add('d-none')
  }

  showProfile() {
    this.wishlistTarget.classList.add('d-none')
    this.profileTarget.classList.remove('d-none')
    this.bookingTarget.classList.add('d-none')
    this.conversationsTarget.classList.add('d-none')
  }

  showConversations() {
    this.wishlistTarget.classList.add('d-none')
    this.profileTarget.classList.add('d-none')
    this.bookingTarget.classList.add('d-none')
    this.conversationsTarget.classList.remove('d-none')
  }

}
