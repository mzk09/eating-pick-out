{
let geocoder

let lat = gon.lat;
let lng = gon.lng;

let map = null;
let marker = null;
let circle = null;

let infowindow;
let currentInfoWindow = null;

let restaurants = gon.restaurants;
let genres = gon.genres;
let images = gon.images;

// console.log(images)

function initSearchMap() {

  geocoder = new google.maps.Geocoder()

  // マップの初期化
  map = new google.maps.Map(document.getElementById('search-map'), {
    center: { lat: lat, lng: lng },
    streetViewControl: false,
    fullscreenControl: false,
    mapTypeControl: false,
    gestureHandling: 'auto',
    zoom: 14,
  });



  // マーカーの初期化
  marker = new google.maps.Marker({
    position: { lat: lat, lng: lng },
    map: map,
    animation: google.maps.Animation.DROP,
  });

  // サークルの初期化
  circle = new google.maps.Circle({
    center: new google.maps.LatLng(lat, lng),
    map: map,
    radius: 1500,
    clickable: false,
    fillColor: '#653e03',
    fillOpacity: 0.1,
    strokeColor: '#653e03',
    strokeOpacity: 0.6,
    strokeWeight: 0.7,
  });

  if (restaurants) {
    //　検索結果の店舗情報の初期化
    initRestaurantInfo();
  }

  // マーカーの移動
  map.addListener('click', function(e){
    clickMap(e.latLng, map);
  });

  // 現在地へ移動ボタンを追加
  const currentLocation = document.createElement('button');
  currentLocation.textContent = '現在地へ移動';
  currentLocation.classList.add("btn", "btn-cur-lo");
  map.controls[google.maps.ControlPosition.TOP_RIGHT].push(currentLocation);

  // 現在地へ移動
  currentLocation.addEventListener('click', () => {
    moveCurrentLocation();
  });
}

//絞込み表示
window.onload = function(){
  let genre_search_class = document.getElementsByClassName('genre_search');
  console.log(genre_search_class);
  let genre_search_array = Array.from(genre_search_class);
  genre_search_array.forEach(function(target){
    target.addEventListener('click', function(e){
      console.log('event');
      console.log(e.target.href);
      var href = e.target.href + '&lat_lng[latitude]=' + document.getElementById('lat').value + '&lat_lng[longitude]=' + document.getElementById('lng').value;
      e.target.href = href;
    });
  });
}

//検索後のマップ作成
let aft
function getAddress(){
  let inputAddress = document.getElementById('address').value;
  geocoder.geocode( { 'address': inputAddress}, function(results, status) {
    if (status == 'OK') {
        //マーカーが複数できないようにする
        if (aft == true){
            marker.setMap(null);
        }

        aft = true

        document.getElementById('lat').value = results[0].geometry.location.lat();
        document.getElementById('lng').value = results[0].geometry.location.lng();

        //中心に移動
        map.panTo(results[0].geometry.location);
        // マーカーとサークルの更新
        updateMarker(results[0].geometry.location, map);
        updateCircle(results[0].geometry.location.lat(), results[0].geometry.location.lng(), map);

} else {
      alert('該当する結果がありませんでした：' + status);
    }
  });
}

 clickMap = (lat_lng, map) => {
  lat = lat_lng.lat();
  lng = lat_lng.lng();

  lat = Math.floor(lat * 10000000) / 10000000;
  lng = Math.floor(lng * 10000000) / 10000000;

  //緯度経度をformに入力する
  document.getElementById('lat').value = lat;
  document.getElementById('lng').value = lng;

  //中心に移動
  map.panTo(lat_lng);

  // マーカーとサークルの更新
  updateMarker(lat_lng, map);
  updateCircle(lat, lng, map);
}

updateMarker = (pos, map) => {
  marker.setMap(null);
  marker = null;
  marker = new google.maps.Marker({
    position: pos,
    map: map
  });
}

updateCircle = (lat, lng, map) => {
  circle.setMap(null);
  circle = null;
  circle = new google.maps.Circle({
    center: new google.maps.LatLng(lat, lng),
    map: map,
    radius: 1500,
    clickable: false,
    fillColor: '#653e03',
    fillOpacity: 0.1,
    strokeColor: '#653e03',
    strokeOpacity: 0.6,
    strokeWeight: 0.7,
  });
}

initRestaurantInfo = () => {
  const labels = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  let labelIndex = 0;
  let restaurantMarkers = [];

  for (let i = 0; i < restaurants.length; i++) {
    let labelText = labels[labelIndex++ % labels.length]

    // 店舗の緯度・経度取得
    markerLatLng = new google.maps.LatLng({
      lat: parseFloat(restaurants[i]['latitude']),
      lng: parseFloat(restaurants[i]['longitude'])
    });

    console.log(restaurants[i])

    // 店舗マーカーの作成
    restaurantMarkers[i] = new google.maps.Marker({
      position: markerLatLng,
      map: map,
      label: {
        text: labelText,
        color: '#f7f6f2',
        fontSize: '18px'
      },
      icon: {
        path: google.maps.SymbolPath.CIRCLE,
        fillColor: "#653e03",
        fillOpacity: 1.0,
        scale: 14,
        strokeColor: "#653e03",
        strokeWeight: 1.0
      },
      animation: google.maps.Animation.DROP
    });

    // markerがクリックされた時、
    restaurantMarkers[i].addListener('click', function(){
      //ウィンドウにジャンル表示
      let genreName;
      for(var s = 0; s < genres.length; s++){
        if(restaurants[i].genre_id == genres[s].id){
          genreName = genres[s].name;
        }
      }
      //ウィンドウ表示用の店舗画像
      let imageUrl;
      for(var q = 0; q < images.length; q++){
        if(restaurants[i].id == images[q].record_id){
          imageUrl = images[q].url;
        }
      }

      console.log(imageUrl)

      // infoWindowを表示
      updateinfowindow(restaurantMarkers[i], restaurants[i], genreName, imageUrl);
    });



    console.log(labelText)


  }
}


updateinfowindow = (restaurantMarker, restaurant, genreName, imageUrl) => {

  // 店舗情報ウィンドウのHTML要素
  const contentHtml =
  '<h4>' + restaurant.name + '</h4>' +
  '<img src="' + imageUrl + '" width="70" height="70">' +
  '<div class="restaurant-info">' +
    '<h5>住所</h5>' +
    '<p class="content">' + restaurant.address + '</p>' +
  '</div>' +
  '<div class="restaurant-info">' +
    '<h5 class="title">営業時間</h5>' +
    '<p class="content">' + restaurant.business_time + '</p>' +
  '</div>' +
  '<div class="restaurant-info">' +
    '<h5 class="title">ジャンル</h5>' +
    '<p class="content">' + genreName + '</p>' +
  '</div>' +
  '<a class="detail" href="/restaurants/' + restaurant.id + '">詳細ページへ</a>';

  // 現在開いているウィンドウを閉じる
  if(currentInfoWindow) {
    currentInfoWindow.close();
  }

  // 店舗情報ウィンドウの作成
  infowindow = new google.maps.InfoWindow({
      content: contentHtml,
      maxWidth: 200,
    });

  // 店舗情報ウィンドウを開く
  infowindow.open({
    anchor: restaurantMarker,
    map,
  });

  currentInfoWindow = infowindow;
}


moveCurrentLocation = () => {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      (position) => {
        var pos = {
          lat: position.coords.latitude,
          lng: position.coords.longitude,
        };
        map.setCenter(pos);
        updateMarker(pos, map);
        updateCircle(pos.lat, pos.lng, map);
        document.getElementById('lat').value = pos.lat;
        document.getElementById('lng').value = pos.lng;
      },
      (error) => {
        var errorInfo = [
          '原因不明のエラーが発生しました',
          'ウェブサイトの許可を得ていないため位置情報の取得に失敗しました。',
          '内部エラー発生により位置情報の取得に失敗しました。',
          'タイムアウトにより位置情報の取得に失敗しました。'
        ];

        var errorMessage = errorInfo[error.code]
        alert(errorMessage);
      }
    );
  } else {
    window.alert('ご使用の端末では対応しておりません。');
  }
}

window.initMap = initSearchMap;
}