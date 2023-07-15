import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['userLink']

  connect() {
    console.log(this.userLinkTargets)
  }

  show(event) {
    event.preventDefault()

    this.load()
  }

  load() {
    fetch(this.userLinkTarget.href)
      .then((response) => response.text())
      .then((data) => this.append(data))
      .catch((error) => console.log(`${error}`))
  }

  append(data) {
    let roomWindow = document.querySelector('#modal')

    if (!roomWindow) {
      roomWindow = document.createElement('div')
      roomWindow.id = 'modal'
      roomWindow.classList.add('room')
      document.querySelector('main').appendChild(roomWindow)
    }

    roomWindow.innerHTML = data
  }


}
