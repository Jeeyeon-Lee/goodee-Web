var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/', function (req, res, next) {
  res.send('respond with a resource');
});
// res.send 파라미터에 문자열이 출력
// res.render 파라미터에 화면이 출력이 됨
router.get('/cart', function (req, res, next) {
  res.render('index', { title: '장바구니', pageName: 'users/cart.ejs' });
});
router.get('/join', function (req, res, next) {
  res.render('index', { title: '회원가입', pageName: 'users/join.ejs' });
});
router.get('/mypage', function (req, res, next) {
  res.render('index', { title: 'MyPage', pageName: 'users/mypage.ejs' });
});

router.get('/update', function (req, res, next) {
  res.render('index', { title: '회원정보수정', pageName: 'users/update.ejs' });
});

module.exports = router;
