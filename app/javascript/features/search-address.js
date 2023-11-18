window.addEventListener('DOMContentLoaded', () => {
  // 住所検索ボタン
  const searchAddressButton = document.querySelector('#search_address_button');
  // 住所検索ボタンがページになければここで処理を終了
  if (!searchAddressButton) return;
  
  // クリックをトリガーにsearchAddress関数を実行
  searchAddressButton.addEventListener('click', searchAddress);
  
  async function searchAddress() {
    // 検索エラーテキスト
    const errorText = document.querySelector('#search_address_error_text');
    // 郵便番号入力フィールド
    const postalCodeField = document.querySelector('#user_postal_code, #cat_postal_code');
    // 都道府県セレクトボックス
    const prefectureSelect = document.querySelector('#user_prefecture, #cat_prefecture');
    // 市区町村入力フィールド
    const cityField = document.querySelector('#user_city, #cat_city');

    // 郵便番号検索APIにリクエスト
    const url = `https://zipcloud.ibsnet.co.jp/api/search?zipcode=${postalCodeField.value}`;
    const response = await fetch(url);
    const json = await response.json();

    if (json.status == 200 && json.results) {
      // 成功時の処理
      errorText.style.display = 'none';
      const result = json.results[0]
      prefectureSelect.value = result.address1;
      cityField.value = result.address2;
    } else {
      // 失敗時の処理
      errorText.style.display = 'block';
      prefectureSelect.value = null;
      cityField.value = null;
    }
  }
});