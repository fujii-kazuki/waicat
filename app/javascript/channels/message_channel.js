import consumer from "./consumer"

consumer.subscriptions.create("MessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const messageList = document.querySelector('#message-list');
    const message = document.createElement('li');
    message.setAttribute('user-id', data.user.id)
    message.innerHTML = data.message.body
    messageList.appendChild(message);
  }
});
