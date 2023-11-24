// - 함수 선언문 function name(){}
// - 함수 표현식 const name = function(){} - 익명함수(자바;익명클래스)
// - IIFE(Immedicately-Invoked Function Expressions)
let hap = function (a, b) {
  return a + b
}
let hap2 = function sum(a, b) {
  return a + b
}
hap = (a, b) => a + b //return 생략 가능
console.log(hap(1, 2))
// sum(3,4) sum defined 외부에서 사용x
// - 즉시 실행 함수 표현 IIFE(Immedicately-Invoked Function Expressions) ->선언하면서 ();에서 바로 호출, 신기방기
;(function run() {
  console.log('run')
})()
