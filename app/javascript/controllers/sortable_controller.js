import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  static targets = ["item"];
  static values = {
    url: String,
    paramName: { type: String, default: "position" },
    handle: { type: String, default: ".drag-handle" },
  };

  connect() {
    this.sortable = Sortable.create(this.element, {
      animation: 150,
      handle: this.handleValue,
      onEnd: this.end.bind(this),
    });
  }

  end(event) {
    const id = event.item.dataset.id;
    const newPosition = event.newIndex + 1;

    const data = {};
    data[this.paramNameValue] = newPosition;

    fetch(`${this.urlValue}/${id}/reorder`, {
      method: "PATCH",
      headers: {
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: JSON.stringify(data),
    })
    .then(response => {
      if (!response.ok) {
        throw new Error("Reorder response was not ok");
      }
    })
    .catch(_error => {
      this.sortByPosition();
    })
  }

  sortByPosition() {
    const order = Array.from(this.element.children)
                       .sort((a, b) => a.dataset.position - b.dataset.position)
                       .map(el => el.dataset.id);
    this.sortable.sort(order);             
  }
}
