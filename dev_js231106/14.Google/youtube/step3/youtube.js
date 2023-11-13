//key 이벤트
const keyword = document.querySelector('#keyword')
keyword.addEventListener('keydown', (e) => {
  console.log(e.keyCode)
})

//사용자가 입력한 검색어 읽어오기
const handleSearch = () => {
  const user = document.querySelector('#keyword').value //사용자가 입력한 글자 얻어오기
  console.log('사용자가 입력한 검색어 =>' + user)
  //사용자 입력 검색어로 조건 검색 구현하기
}

//변수명이 user -> query로.. 다양하게 작성하면 헷갈림
const search = (query) => {
  console.log('사용자 입력 nba 가져오기' + query)
  //검색결과 가져오는 코드
  const YoutubeSearch_URL =
    'https://www.googleapis.com/youtube/v3/search?part=snippet&key=AIzaSyCcvgxRhPCt-yVa-BcpGUi1dmM4hKYiEi4&type=video&q=#'
  ajax.open('GET', YoutubeSearch_URL, false)
  ajax.send()
}

const ajax = new XMLHttpRequest()
const Youtube_URL =
  'https://www.googleapis.com/youtube/v3/videos?part=snippet&key=AIzaSyAzxSeXI1gsMWlv9rjkOfzasmyOcux9MX0&maxResults=15&chart=mostPopular'
ajax.open('GET', Youtube_URL, false)
ajax.send()

//배열사용 템플릿 array
const videoList = []

const most = JSON.parse(ajax.response)
const items = most.items

let content = ''
videoList.push(`<ul class="videos">`)
for (let i = 0; i < items.length; i++) {
  //25번 반복 - 25개의 li)
  videoList.push(`<li class="container">`)
  videoList.push(`<div class="video">`)
  videoList.push(
    `<img class="thumbnail" src='${items[i].snippet.thumbnails.medium.url}'/>`,
  )
  videoList.push(`<div>`)
  videoList.push(`<p class="title">${items[i].snippet.title}</p>`)
  videoList.push(`<p class="channelTitle">${items[i].snippet.channelTitle}</p>`)
  videoList.push(`</div>`)
  videoList.push(`</div>`)
  videoList.push(`</li>`)
}
videoList.push(`</ul>`)

document.querySelector('#root').innerHTML = videoList.join('')
