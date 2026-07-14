import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["output"];

  show() {
    this.outputTarget.innerHTML = `<div class="border w-[7rem] h-[7rem] p-2"><p class="text-xs m-0">[i] the numbers determine the order :)</p>
  <pre>folder/
├─ 1.png
├─ 2.txt
├─ 3.mp3
</pre></div>`;
  }

  clear() {
    this.outputTarget.innerHTML = "";
  }
}
