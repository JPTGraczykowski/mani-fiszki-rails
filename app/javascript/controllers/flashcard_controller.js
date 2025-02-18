import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["text"];
  static values = {
    englishName: String,
    polishName: String,
    state: String
  }

  toggle() {
    if (this.stateValue === "english") {
      this.textTarget.innerText = this.polishNameValue;
      this.stateValue = "polish";
    } else {
      this.textTarget.innerText = this.englishNameValue;
      this.stateValue = "english";
    }
  }
}
