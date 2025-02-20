import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toggle", "toggleBackground", "label"];
  static values = { preferredLanguage: String };

  connect() {
    this.preferredLanguageValue = this.preferredLanguageValue || "english"
    this.updateUI()
  }

  toggle() {
    this.preferredLanguageValue = this.preferredLanguageValue === "english" ? "polish" : "english";
    this.updateUI();
  }

  updateUI() {
    if (this.preferredLanguageValue === "english") {
      this.labelTarget.innerText = "Angielski";
      this.toggleTarget.classList.remove("translate-x-6");
      this.toggleBackgroundTarget.classList.remove("bg-lime-200")
    } else {
      this.labelTarget.innerText = "Polski";
      this.toggleTarget.classList.add("translate-x-6");
      this.toggleBackgroundTarget.classList.add("bg-lime-200")
    }
  }
}
