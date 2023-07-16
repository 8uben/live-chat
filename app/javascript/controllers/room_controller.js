import { Controller } from "@hotwired/stimulus"
import consumer from "channels/consumer"

export default class extends Controller {
  static targets = [ 'input', 'messages' ]
  static values = { 'id': Number, 'currentUserId': Number }

  connect() {
    this.scrollDown()
    this.subscribeToRoomChannel()
  }

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
      .then(() => this.scrollDown())
      .catch((error) => console.log(`${error}`))
  }

  appendMessage(data) {
    const template = data.template
    const parser = new DOMParser()
    const doc = parser.parseFromString(template, 'text/html')

    let contentElement = doc.querySelector('[data-room-target]')

    if (this.currentUserIdValue !== data.message.user_id) {
      contentElement.classList.add('!justify-start')
      contentElement.firstElementChild.classList.add('!bg-gray-700')
    }

    this.messagesTarget.appendChild(contentElement)
  }

  resetInput() {
    this.inputTarget.value = ''
  }

  scrollDown() {
    this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight;
  }

  subscribeToRoomChannel() {
    consumer.subscriptions.create({channel: 'RoomChannel', room_id: this.idValue}, {
      received: this._received.bind(this)
    })
  }

  _received(data) {
    this.appendMessage(data)
  }
}
