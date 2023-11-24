/*
아래는 동기인가 비동기인가?
순서대로 처리되는 js의 흐름을 바꾸는 것은 논리적 오류, 트러블 슈팅이 가능해야함. 
setTimeout(콜백함수,지연되는 시간)
*/

const hap = (a, b) => {
  setTimeout(() => {
    return a + b
  }, 1000)
}

const x = hap(1, 2)
const y = x
console.log(x);
console.log(y);
