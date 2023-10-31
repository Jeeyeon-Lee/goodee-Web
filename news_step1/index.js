// console.log('hello parcel'); //번들러
const ajax = new XMLHttpRequest();  // 브라우저가 비동기처리를 위해 제공하는 내장객체임
const NEWS_URL = 'https://api.hnpwa.com/v0/news/1.json';
// open은 XMLHttpRequest 객체가 제공하는 함수로 파라미터는 3개가 필요함
// 1.전송방식 2. 요청하는 URL, 3. true:동기, false:비동기 처리로 요청해줌
// ajax변수는 XMLHttpRequest를 참조하는 변수명임

ajax.open('GET',NEWS_URL,false)
ajax.send();  // 호출시 바로 서버측 요청발생

const newsList = JSON.parse(ajax.response);  //위 요청을 서버에서 받아오는 속성 response
console.log(newsList); // 서버측에서 보낸 응답 출력해보기 - Array로 변화 출력

const ul = document.createElement('ul')  // DOM API 가지고 태그를 만드니까 직관적이지 않다. DOM Tree 그려지지 않아서
for(let i=0; i<10 ; i++){
  const li = document.createElement('li')
  //console.log(newsList[i].title);
  li.innerHTML = newsList[i].title;
  ul.appendChild(li);
}
document.getElementById('root').appendChild(ul);