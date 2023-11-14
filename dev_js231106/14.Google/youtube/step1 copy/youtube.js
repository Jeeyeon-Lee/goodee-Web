var requestOptions = {
  method: 'GET',
  redirect: 'follow'
};

fetch("https://www.googleapis.com/youtube/v3/videos?part=snippet&key=AIzaSyAzxSeXI1gsMWlv9rjkOfzasmyOcux9MX0&maxResults=12&chart=mostPopular", requestOptions)
  .then(response => response.text())
  .then(result => console.log(result))
  .catch(error => console.log('error', error));

// const ajax = new XMLHttpRequest()
// const Youtube_URL =
//   'https://www.googleapis.com/youtube/v3/videos?part=snippet&key=AIzaSyAzxSeXI1gsMWlv9rjkOfzasmyOcux9MX0&maxResults=15&chart=mostPopular'
// ajax.open('GET', Youtube_URL, false)
// ajax.send()

// console.log(ajax.response)
const most = JSON.parse(ajax.response)
const items = most.items
console.log(items)
console.log(items.length)

//JSON 정보를 아래처럼 각 영역으로 불러오는 법 다시 복습 필요
let content = ''
content += `<ul class="videos">`
for (let i = 0; i < items.length; i++) {
  //25번 반복 - 25개의 li
  content += `<li class="container">`
  content += `<div class="video">`
  content += `<img class="thumbnail" src='${items[i].snippet.thumbnails.medium.url}'/>`
  content += `<div>`
  content += `<p class="title">${items[i].snippet.title}</p>`
  content += `<p class="channelTitle">${items[i].snippet.channelTitle}</p>`
  content += `</div>`
  content += `</div>`
  content += `</li>`
}
content += `</ul>`

document.querySelector('#root').innerHTML = content
