const ajax = new XMLHttpRequest(); //브라우저가 비동기처리를 위해 제공하는 내장객체임
const TITLE_URL = 'https://api.hnpwa.com/v0/news/1.json';
const CONTENT_URL = 'https://api.hnpwa.com/v0/item/@id.json';
const container = document.getElementById('root');
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
  // 원래는 눌렀을 때 아래에 추가되게 append 했었음.
  // title.innerHTML = ncontent.title;
  // content.appendChild(title);
  // append가 아닌 덮어쓰기로 표시됨
  container.innerHTML = `
    <h1>${ncontent.title}</h1>
    <div><a href="#">목록으로</a></div>
  `;
});

//배열선언하기 - 뉴스목록을 배열로 담아서 한번에 넣기
const newsPage = []; //빈 배열 선언(안에 ul, li 한번에 넣기)
//배열더하기 Array.prototype.push (여는태그, 닫는태그 다 배열로 추가해야함!)
newsPage.push('<ul>');
for (let i = 0; i < 10; i++) {
  newsPage.push(`
    <li>
      <a href="#${newsList[i].id}">
        ${newsList[i].title}, (😍${newsList[i].comments_count})
      </a>
    </li>
  `);
} //end of for
newsPage.push('</ul>');
//배열의 값들을 합쳐서 만드는 함수 join() -> 디폴트는 콤마, but 구분자 역할하는 빈문자열로 입력??
container.innerHTML = newsPage.join('');

// DOM API로 페이지를 그렸더니 직관적x
// 이것을 개선하고자 문자열을 이용하여 태그를 이어붙여 코드양은 늘리되
// 복잡도는 낮춰보고자 함.
// createElement, appendChild 다 걷어낸다.
