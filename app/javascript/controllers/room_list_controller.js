import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'input', 'list' ]

  submit(event) {
    event.preventDefault();

    const form = event.target;
    const url = form.action;

    this.load(url, form)
    this.resetInput()
  }

  load(url, data) {
    fetch(url, {
      method: 'POST',
      body: new FormData(data)
    }).then((response) => response.text())
      .then((data) => this.append(data))
      .catch((error) => console.log(`${error}`))
  }

  append(data) {
    this.listTarget.innerHTML += data
  }

  resetInput() {
    this.inputTarget.value = ''
  }
}
