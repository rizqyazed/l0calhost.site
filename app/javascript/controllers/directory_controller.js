import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["title", "desc"];

  show(event) {
    const title = event.params.title;
    const desc = event.params.desc;

    this.titleTarget.textContent = title;
    this.descTarget.innerHTML = desc;

    this.titleTarget.classList.remove("italic");
    this.descTarget.classList.remove("italic");
  }

  clear() {
    this.titleTarget.textContent = " ";
    this.descTarget.innerHTML = " ";

    this.titleTarget.classList.remove("italic");
    this.descTarget.classList.remove("italic");
  }
}
