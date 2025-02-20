import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["flash"];

  connect() {
    setTimeout(() => {
      this.flashTarget.classList.add("opacity-0", "translate-x-2");
      setTimeout(() => this.flashTarget.remove(), 500);
    }, 3000);
  }
}
