//외부 프레임워크 가져올 때 사용하는 예약어
var express = require('express');
var router = express.Router();

/* GET home page. 
express가 restful API 지원, 웹 서비스를 제공할 수 잇게 해 줌(서블릿, jsp)
router 페이지 전환 API, 화면전환 처리 이벤트*/
//자바는 메인에서 실행되었다면, 웹서비스는 요청마다(URL마다) 함수를 구현한다.
// get('URL',) -> URL 주소마다 반드시 함수 설계 및 구현된다.
router.get('/', function (req, res, next) {
  res.render('index', { title: '도서관리시스템', pageName: 'home.ejs' });
});
router.get('/login', function (req, res, next) {
  res.render('index', { title: '로그인', pageName: 'auth/login.ejs' });
});
router.get('/board', function (req, res, next) {
  res.render('index', { title: '글목록', pageName: 'board/list.ejs' });
});
router.get('/board/write', function (req, res, next) {
  res.render('index', { title: '글쓰기', pageName: 'board/write.ejs' });
});
router.get('/board/:id', function (req, res, next) {
  let id = req.params.id;
  res.render('index', {
    title: '상세보기',
    pageName: 'board/read.ejs',
    id: id,
  });
});
router.get('/board/update/:id', function (req, res, next) {
  let id = req.params.id;
  res.render('index', {
    title: '글수정',
    pageName: 'board/update.ejs',
    id: id,
  });
});

module.exports = router;
