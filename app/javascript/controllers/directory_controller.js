import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["website"];

  show(event) {
    const siteInfo = event.params.info;

    this.outputTarget.textContent = siteInfo;

    this.outputTarget.classList.remove("italic");
  }

  clear() {
    this.outputTarget.textContent = " ";
    this.outputTarget.classList.add("italic");
  }
}
