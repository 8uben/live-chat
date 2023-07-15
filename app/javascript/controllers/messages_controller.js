import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'input', 'messages' ]

  connect() {
    this.scrollDown()
  }

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
      .then(() => this.scrollDown())
      .catch((error) => console.log(`${error}`))
  }

  append(data) {
    this.messagesTarget.innerHTML += data
  }

  resetInput() {
    this.inputTarget.value = ''
  }

  scrollDown() {
    this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight;
  }
}
