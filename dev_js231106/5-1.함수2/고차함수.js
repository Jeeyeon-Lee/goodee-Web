//고차함수
//반환타입의 자리에 함수가 옴. 출력을 위해선 8,9번 과정

//할당연산자로 받아내기 - 익명의 함수
const sayHello = () => {
  return function () {
    console.log('hello')
  }
}
console.log(sayHello) // [Function : sayHello]

//출력을 위해 필요한과정
const myFunc = sayHello()
sayHello()

console.log(myFunc) //[Function (anonymous : 익명)]
hap = (a, b) => {
  return a + b
}
// 함수도 객체, 치환하는 순간 같은 주소를 갖게 됨.
const add = hap
console.log(add)
console.log(hap)
