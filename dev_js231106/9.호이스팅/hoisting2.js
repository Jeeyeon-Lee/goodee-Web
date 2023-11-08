//ES5 시절의 호이스팅 이슈 피하기 -> 즉시실행함수 사용

const btns = document.querySelectorAll('ul li')
//btns는 array(object)임. length를 받아들이잖아.
console.log(typeof btns)
console.log(btns.length)
//ES5까진 var 사용
//ES6에서 var의 호이스팅 이슈를 없애고자 let이 생겨남

//var는 for문이 다 돌고나서 전변에 그 값이 저장되어 이슈가 발생함.
//호이스팅 이슈 해결방법
//1. ES6 이후 let을 사용한 호이스팅 이슈 없던 함수
for (let i = 0; i < btns.length; i++) {
  btns[i].addEventListener('click', (event) => {
    console.log(event.target)
    console.log(i)
  })
}

//괄호로 가두고 파라미터로 i를 받지만, 가두어진 파라미터 자리에 index 변수를 사용하여 문제를 해결함.
//2. ES5에서 호이스팅 이슈 해결하던 즉시실행함수
for (var i = 0; i < btns.length; i++) {
  ((index) => {
    btns[i].addEventListener('click', (event) => {
      console.log(event.target)
      console.log(i)
    })
  })(i) //즉시실행 부분
}
