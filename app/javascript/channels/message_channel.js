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
    if (!messageList) return;

    const messageListItem =`
      <li class="message-list__item" user-id="${data.user.id}">
        <div class="message-list__item-avatar-wrap">
          <a href="/users/${data.user.id}">
            <img src="${getProfileImage(data.user.id)}">
          </a>
        </div>

        <p class="message-list__item-user-name">
          ${data.user.name}
        </p>

        <p class="message-list__item-body">
          ${data.message_body.replace(/\r?\n/g, '<br>')}
        </p>

        <time class="message-list__item-created-at">
          ${data.message_created_at}
        </time>
      </li>`;

    messageList.insertAdjacentHTML('beforeend', messageListItem);

    // userIdから会員のプロフィール画像を取得
    function getProfileImage(userId) {
      const usersProfileImageUrl = document.querySelector('#users-profile-image-url');
      return usersProfileImageUrl.getAttribute(`user-${userId}-avatar-src`);
    }
  }
});
