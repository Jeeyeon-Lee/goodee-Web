//페이징
//content_URL id값만 가져옴 + 페이지번호, 있었던 주소 확인 필요
//@ioid JSON파일에서 id 가져와서 치환했음.
//#3807789 -> substring(1) ->3807789
//상세페이지 - 구분 - show +
//목록페이지 - 구분 - page +
//http://localhost:1234/#38099086 -> substring(1)
//페이지 번호 계속 바뀜(상태 바뀜) -> 관리(쿠키, 세션)
//http://localhost:1234/#/page/1  -> substring(7)
//http://localhost:1234/#/page/2  -> 2
//http://localhost:1234/#/page/3  -> 3
//http://localhost:1234/#/show/38099086
//http://localhost:1234/#/show/38099086
const ajax = new XMLHttpRequest(); //브라우저가 비동기처리를 위해 제공하는 내장객체임
const TITLE_URL = 'https://api.hnpwa.com/v0/news/1.json'; //목록, hashchange 일어나지 않음.
const CONTENT_URL = 'https://api.hnpwa.com/v0/item/@id.json'; //내용, hashchange 일어남, id값 가져옴.+ 페이지번호
const container = document.getElementById('root');
const content = document.createElement('div');
const ul = document.createElement('ul');
//페이징 처리를 위해 필요한 상태값 관리 객체 선언(vo 느낌)
//react 상태관리 시 만드는 이름임 -> detail창에서 원래 있던 곳로 이동하는 '돌아가기'를 사용하기 위해 상태관리 필요
const store = {
  currentPage: 1,
  totalRecord: 47,
};
getData = (url) => {
  ajax.open('GET', url, false);
  ajax.send(); //서버측에 요청 보내고 응답 기다리는 중
  return JSON.parse(ajax.response);
};

// 이전페이지, 다음페이지
// 제목클릭시(a태그 발동) 상세화면으로 간다(라우팅->newsDetail) show 추가
// #/show/2 -> substring(7) -> number(2) -> Integer.number
getNewsData = () => {
  const newsData = getData(TITLE_URL);
  const newsPage = [];
  newsPage.push('<ul>');
  //10개씩만 한 화면에 출력하기(0-9, 10-19,20-29)
  for (let i = (store.currentPage - 1) * 10; i < store.currentPage * 10; i++) {
    newsPage.push(`
      <li>
        <a href="#/show/${newsData[i].id}">
          ${newsData[i].title}, (😍${newsData[i].comments_count})
        </a>
      </li>
    `);
  } //end of for
  newsPage.push('</ul>');
  //이전, 다음페이지 버튼 넣기(삼항연산자로)
  newsPage.push(`
    <div>
      <a href="#/page/${
        store.currentPage > 1 ? store.currentPage - 1 : 1
      }">이전페이지</a>  
      
      <a href="#/page/${
        store.currentPage < 3 ? store.currentPage + 1 : 3
      }">다음페이지</a>  
    </div>
  `);

  container.innerHTML = newsPage.join('');
};

// 페이지로 이동하는 것 추가 page
newsDetail = () => {
  const id = location.hash.substring(7);
  const ncontent = getData(CONTENT_URL.replace('@id', id));
  container.innerHTML = `
    <h1>${ncontent.title}</h1>
    <div><a href="#/page/${store.currentPage}">목록으로</a></div>
  `;
};
//router에도 show, page의 경우도 추가해야함.
router = () => {
  const routerPath = location.hash;
  // 타입까지 같니? ===
  //#만 있으면 빈값을 반환함 -> 글목록보기로 이동(최초 한 번만 사용됨->전처리 과정)
  if (routerPath === '') {
    getNewsData(); //글 목록보기
  }
  // #/page/이런 형태로 들어와 있으면 1이니까 0보다 큼 ->페이지에서 뉴스목록보기 newsData
  else if (routerPath.indexOf('#/page/') >= 0) {
    //현재 페이지값 갖게 하기(전변의 느낌으로) ->
    store.currentPage = Number(routerPath.substring(7));
    getNewsData();
  }
  // routerPath에 '#/page/'이 아닌경우 -> #/show/의 경우, 뉴스내용보기 detail 함수를 실행
  else {
    newsDetail(); //글 내용보기
  }
};

//함수 호출 가능
window.addEventListener('hashchange', router);
router();
// window.addEventListener('hashchange', newsDetail);
// getNewsData();
