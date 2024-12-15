import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "form"];

  search() {
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      this.formTarget.requestSubmit();
      this.inputTarget.focus(); // Ensure the input retains focus
    }, 300); // 300ms debounce for smoother user experience
  }
}