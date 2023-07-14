import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'input', 'list' ]

  submit(event) {
    event.preventDefault();

    const form = event.target;
    const url = form.action;

    const submitResponse = fetch(url, {
      method: 'POST',
      body: new FormData(form)
    }).then((response) => response.text())
      .catch((error) => console.log(`${error}`))

    this.append(submitResponse)
    this.resetInput()
  }

  append(data) {
    this.listTarget.innerHTML += data
  }

  resetInput() {
    this.inputTarget.value = ''
  }
}
