import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['userLink']

  show(event) {
    event.preventDefault()

    this.load()
  }

  load() {
    fetch(this.userLinkTarget.href)
      .then((response) => response.text())
      .then((text) => this.parseModalwindow(text))
      .then((element) => this.append(element))
      .catch((error) => console.log(`${error}`))
  }

  append(data) {
    let roomWindow = document.querySelector('#modal')

    if (!roomWindow) {
      document.querySelector('main').appendChild(data)
    } else {
      roomWindow.replaceChildren(data)
    }
  }

  parseModalwindow(text) {
    const parser = new DOMParser()
    const doc = parser.parseFromString(text, 'text/html')
    return doc.getElementById('modal')
  }
}
