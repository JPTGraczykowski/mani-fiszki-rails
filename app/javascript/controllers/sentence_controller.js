import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["wordGap"];
  static values = { missingWordId: String };

  selectWord(event) {
    const selectedWord = event.target;
    const wordGap = document.getElementById("word-gap");
    const wordsToChoose = document.querySelectorAll(".word-to-choose");

    wordGap.parentNode.classList.remove("bg-lime-200");
    wordGap.parentNode.classList.remove("bg-red-200");
    wordsToChoose.forEach((word) => {
        word.classList.remove("bg-lime-200");
        word.classList.remove("bg-red-200");
    });

    wordGap.innerText = selectedWord.dataset.wordValue;

    if (selectedWord.dataset.wordId === this.missingWordIdValue) {
      selectedWord.classList.add("bg-lime-200");
      wordGap.parentNode.classList.add("bg-lime-200");
    } else {
      selectedWord.classList.add("bg-red-200");
      wordGap.parentNode.classList.add("bg-red-200");
    }
  }
}
