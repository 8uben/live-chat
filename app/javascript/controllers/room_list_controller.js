import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'input', 'privateList', 'publicList', 'item' ]

  submit(event) {
    event.preventDefault();

    const form = event.target;
    const url = form.action;

    this.dataSubmit(url, form)
    this.resetInput()
  }

  dataSubmit(url, data) {
    fetch(url, {
      method: 'POST',
      body: new FormData(data)
    }).then((response) => response.text())
      .then((data) => this.appendItem(data))
      .catch((error) => console.log(`${error}`))
  }

  appendItem(data) {
    this.publicListTarget.innerHTML += data
  }

  resetInput() {
    this.inputTarget.value = ''
  }

  click(event) {
    event.preventDefault()

    this.openItem(event)
  }

  openItem(event) {
    fetch(event.srcElement.href)
      .then((response) => response.text())
      .then((text) => this.parseModal(text))
      .then((element) => this.appendModal(element))
      .catch((error) => console.log(`${error}`))
  }

  appendModal(data) {
    let roomWindow = document.querySelector('#modal')

    if (!roomWindow) {
      document.querySelector('main').appendChild(data)
    } else {
      roomWindow.replaceChildren(data)
    }
  }

  parseModal(text) {
    const parser = new DOMParser()
    const doc = parser.parseFromString(text, 'text/html')
    return doc.getElementById('modal')
  }
}
