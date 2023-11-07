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

module.exports = router;
