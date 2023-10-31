const ajax = new XMLHttpRequest(); //브라우저가 비동기처리를 위해 제공하는 내장객체임
const TITLE_URL = 'https://api.hnpwa.com/v0/news/1.json';
const CONTENT_URL = 'https://api.hnpwa.com/v0/item/@id.json';
const contatiner = document.getElementById('root');
const content = document.createElement('div');

//@param url - title or content URL
//@return    - Array(<-JSON을 변환)
getData = (url) => {
  ajax.open('GET', url, false);
  ajax.send(); //서버측에 요청 보내고 응답 기다리는 중
  return JSON.parse(ajax.response);
};

const newsList = getData(TITLE_URL); //6번에서 요청했을 때 서버측의 응답을 받아오는 속성이 response임
console.log(newsList); //서버측에서 보낸 응답을 출력해 보기 -Array로 변환하여 출력해줌
const ul = document.createElement('ul'); //DOM  API가지고 태그를 만드니까 직관적이지 않다. DOM Tree그려지지 않아서.
window.addEventListener('hashchange', () => {
  const id = location.hash.substring(1);
  const ncontent = getData(CONTENT_URL.replace('@id', id), false);
  const title = document.createElement('h1');
  title.innerHTML = ncontent.title;
  content.appendChild(title);
});
for (let i = 0; i < 5; i++) {
  const li = document.createElement('li'); //li생성
  const a = document.createElement('a'); //a 생성
  a.href = `#${newsList[i].id}`;
  a.innerHTML = `${newsList[i].title}(👍${newsList[i].comments_count})`;
  li.appendChild(a); // <li><a></a></li>
  ul.appendChild(li); // <ul><li><a></a></li></ul>
} //end of for
contatiner.appendChild(ul); // <div id = 'root'><ul></ul></div>
contatiner.appendChild(content); // <div id = 'root'><ul><div></div></ul></div>
