const ajax = new XMLHttpRequest(); //브라우저가 비동기처리를 위해 제공하는 내장객체임
const TITLE_URL = 'https://api.hnpwa.com/v0/news/1.json';
const CONTENT_URL = 'https://api.hnpwa.com/v0/item/@id.json';
const container = document.getElementById('root');
const ul = document.createElement('ul'); //DOM  API가지고 태그를 만드니까 직관적이지 않다. DOM Tree그려지지 않아서.

getData = (url) => {
  ajax.open('GET', url, false);
  ajax.send(); //서버측에 요청 보내고 응답 기다리는 중
  return JSON.parse(ajax.response);
};

getNewsData = () => {
  const newsData = getData(TITLE_URL);
  const newsPage = [];
  newsPage.push('<ul>');
  for (let i = 0; i < 10; i++) {
    newsPage.push(`
      <li>
        <a href="#${newsData[i].id}">
          ${newsData[i].title}, (😍${newsData[i].comments_count})
        </a>
      </li>
    `);
  } //end of for
  newsPage.push('</ul>');
  container.innerHTML = newsPage.join('');
};

newsDetail = () => {
  const id = location.hash.substring(1);
  console.log(id);
  const ncontent = getData(CONTENT_URL.replace('@id', id));
  container.innerHTML = `
    <h1>${ncontent.title}</h1>
    <div><a href="#">목록으로</a></div>
  `;
};

router = () => {
  const routerPath = location.hash;
  // 타입까지 같니? ===
  //#만 있으면 빈값을 반환함 -> 글목록보기로 이동
  if (routerPath === '') {
    getNewsData(); //글 목록보기
  } else {
    newsDetail(); //글 내용보기
  }
};

//함수 호출 가능
window.addEventListener('hashchange', router);
router();
// window.addEventListener('hashchange', newsDetail);
// getNewsData();
