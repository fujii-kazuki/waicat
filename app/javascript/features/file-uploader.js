window.addEventListener('DOMContentLoaded', () => {
  // 写真をアップロードするinput要素にイベントを追加
  addPhotoInputEvent();
  // 映像をアップロードするinput要素にイベントを追加
  addVideoInputEvent();
  // 映像削除ボタンにイベントを追加
  addDeleteVideoButtonEvent();
});

// 写真をアップロードするinput要素にイベントを追加
function addPhotoInputEvent() {
  // 写真をアップロードするinput要素
  const photoUploader = document.querySelector('#photo-uploader');
  // ページに要素がなければここで処理を終了
  if (!photoUploader) return;
  
  // プレビュー画像を追加する要素
  const newPhotosPreview = document.querySelector('#new-photos-preview');
  // 写真の最大ファイル数
  const maxPhotoNum = 10;
  // 写真の指定ファイル形式
  const photoAcceptFormats = ['image/jpeg', 'image/png'];
  // 写真の制限サイズ
  const photoSizeLimit = 1024 * 1024 * 5; //5MB

  photoUploader.addEventListener('change', (event) => {
    // 写真のプレビューを全て削除
    newPhotosPreview.innerHTML = '';

    const files = event.target.files
    // アップロードされたファイルを確認
    if (files.length > maxPhotoNum) {
      // ファイル数が多い
      alert('ファイルは一度に10枚以上アップロードできません。'); //エラーメッセージを表示
      event.target.value = ''; //inputの中身をリセット
      newPhotosPreview.innerHTML = ''; // 写真のプレビューを全て削除
      return;
    }

    for (let i = 0; i < files.length; i++) {
      if (!photoAcceptFormats.includes(files[i].type)) {
        // ファイル形式が非対応
        alert('非対応の形式のファイルが含まれています。'); //エラーメッセージを表示
        event.target.value = ''; //inputの中身をリセット
        newPhotosPreview.innerHTML = ''; // 写真のプレビューを全て削除
        return;
      }

      if (files[i].size > photoSizeLimit) {
        // ファイルサイズが制限以上
        alert('サイズが5MBを超えているファイルが含まれています'); //エラーメッセージを表示
        event.target.value = ''; //inputの中身をリセット
        newPhotosPreview.innerHTML = ''; // 写真のプレビューを全て削除
        return;
      }

      // 写真のプレビューを表示する
      photoPreview(files[i]);
    }
  });

  // 写真のプレビューを表示する
  function photoPreview(photo) {
    // 写真のプレビュー要素の作成・表示
    const imgWrap = document.createElement('div');
    imgWrap.className = 'publish-edit__new-photo-wrap'
    const img = document.createElement('img');
    img.src = URL.createObjectURL(photo);
    imgWrap.appendChild(img);
    newPhotosPreview.appendChild(imgWrap);
  }
}

// 映像をアップロードするinput要素にイベントを追加
function addVideoInputEvent() {
  // 映像をアップロードするinput要素
  const videoUploader = document.querySelector('#video-uploader');
  // ページに要素がなければここで処理を終了
  if (!videoUploader) return;

  // 映像のプレビューを追加する要素
  const videoPreviewElem = document.querySelector('#video-preview');
  // 映像の指定ファイル形式
  const videoAcceptFormats = ['video/mp4', 'video/quicktime'];
  // 映像の制限サイズ
  const videoSizeLimit = 1024 * 1024 * 30; //30MB

  videoUploader.addEventListener('change', (event) => {
    // 映像のプレビューを全て削除
    videoPreviewElem.innerHTML = '';

    const file = event.target.files[0];
    if (!videoAcceptFormats.includes(file.type)) {
      // ファイル形式が非対応
      alert('映像ファイルの形式が非対応です。'); //エラーメッセージを表示
      event.target.value = ''; //inputの中身をリセット
      videoPreviewElem.innerHTML = ''; // 映像のプレビューを削除
      return;
    }

    if (file.size > videoSizeLimit) {
      // ファイルサイズが制限以上
      alert('映像ファイルのサイズが30MBを超えています'); //エラーメッセージを表示
      event.target.value = ''; //inputの中身をリセット
      videoPreviewElem.innerHTML = ''; // 映像のプレビューを削除
      return;
    }

    // 映像のプレビューを表示する
    videoPreview(file);
  });

  // 映像のプレビューを表示する
  function videoPreview(file) {
    // 映像のプレビュー要素の作成・表示
    const video = document.createElement('video');
    video.src = URL.createObjectURL(file);
    video.controls = true;
    const videoWrap = document.createElement('div');
    videoWrap.className = 'publish-edit__video-wrap';
    videoWrap.appendChild(video);
    videoPreviewElem.appendChild(videoWrap);
    // 映像削除ボタンを作成し、イベントを追加
    createDeleteVideoButton(videoWrap);
    addDeleteVideoButtonEvent();
  }
}

// 映像削除ボタンにイベントを追加
function addDeleteVideoButtonEvent() {
  const deleteVideoButton = document.querySelector('#video-delete-button');
  // ページに要素がなければここで処理を終了
  if (!deleteVideoButton) return;

  // 映像をアップロードするinput要素
  const videoUploader = document.querySelector('#video-uploader');

  deleteVideoButton.addEventListener('click', (event) => {
    // 親要素毎要素を削除
    event.target.parentElement.remove();
    // inputの中身をリセット
    videoUploader.value = '';
  });
}

// 映像削除ボタンを作成
function createDeleteVideoButton(paremtElem) {
  const button = document.createElement('button');
  button.type = 'button';
  button.id = 'video-delete-button';
  button.className = 'publish-edit__video-delete-button';
  button.innerHTML = '削除';
  paremtElem.appendChild(button);
}