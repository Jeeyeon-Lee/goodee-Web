// Null 값이 존재하지 않음
// let 변수(재정의 o), const 상수(재정의 x)
let age = null;
console.log(age);

// setTimeout(실행,시간) -> 시간이 지난 뒤 실행됨(1초 - 1000) -> 타임라인을 변경할 때 사용(기억)
setTimeout(function () {
  age = 80;
  console.log(age);
}, 3000);
