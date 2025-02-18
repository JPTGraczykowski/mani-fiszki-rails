import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["text"];
  static values = {
    englishName: String,
    polishName: String,
    language: String
  }

  toggle() {
    if (this.languageValue === "english") {
      this.textTarget.innerText = this.polishNameValue;
      this.languageValue = "polish";
    } else {
      this.textTarget.innerText = this.englishNameValue;
      this.languageValue = "english";
    }
  }
}
