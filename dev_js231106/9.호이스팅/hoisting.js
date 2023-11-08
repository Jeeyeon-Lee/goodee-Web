const btns = document.querySelectorAll('ul li')
//btns는 array(object)임. length를 받아들이잖아.
console.log(typeof btns)
console.log(btns.length)
//ES5까진 var 사용
//ES6에서 var의 호이스팅 이슈를 없애고자 let이 생겨남

//배열인지확인
for (let i = 0; i < btns.length; i++) {
  btns[i].addEventListener('click', (event) => {
    console.log(event.target)
    console.log(i)
  })
}
