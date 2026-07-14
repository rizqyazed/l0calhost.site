import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["output"];

  connect() {
    this.defaultText = this.outputTarget.textContent;
  }

  show(event) {
    this.outputTarget.innerHTML = event.params.message;
  }

  clear() {
    this.outputTarget.innterHTML = this.defaultText;
  }
}
