const ajax = new XMLHttpRequest(); //브라우저가 비동기처리를 위해 제공하는 내장객체임
const TITLE_URL = 'https://api.hnpwa.com/v0/news/1.json';
const CONTENT_URL = 'https://api.hnpwa.com/v0/item/@id.json';
const contatiner = document.getElementById('root');
const content = document.createElement('div');
getData = (url) => {
  ajax.open('GET', url, false);
  ajax.send(); //send()호출될 때 비로서 서버측에 요청이 일어남
  return JSON.parse(ajax.response);
};

//뉴스 코멘트 담을 태그 생성하기
const newsList = getData(TITLE_URL);
console.log(newsList); //서버측에서 보낸 응답을 출력해 보기 -Array로 변환하여 출력해줌
const ul = document.createElement('ul'); //DOM  API가지고 태그를 만드니까 직관적이지 않다. DOM Tree그려지지 않아서.

window.addEventListener('hashchange', () => {
  const id = location.hash.substring(1);
  const ncontent = getData(CONTENT_URL.replace('@id', id));
  const title = document.createElement('h1');
  title.innerHTML = ncontent.title;
  content.appendChild(title);
});

for (let i = 0; i < 5; i++) {
  const div = document.createElement('div');
  div.innerHTML = `
    <li>
      <a href="#${newsList[i].id}">
        ${newsList[i].title}(${newsList[i].comments_count})
      </a>
    </li>
    `;
  ul.appendChild(div.firstElementChild);
}

contatiner.appendChild(ul);
contatiner.appendChild(content);
