//파라미터, 매개변수, 인자
//선언 인자는 2개인데, arguments(배열)로 넘어오면 갯수에 상관없이 된다???
//파라미터 정보는 함수 내부 접근 가능한 arguments 객체에 저장됨
function hap(a, b) {
  console.log(arguments) //[Argument] {'0':1,'1':2,'2':3} [Arguments] {'0':1,'1':2,'2':null}
  console.log(arguments[0]) // 1 1
  console.log(arguments[2]) // 3 null
  // return a + b + arguments[2] //2
  return a + b + arguments[1] // -> 이렇게도 사용이 가능함, but 사이드 이펙트 생길 수 있음.
  // return a + b
}

console.log(hap(1, 2, 3)) //5
console.log(hap(1, 2, null)) //5
console.log(hap(4, 5, 4)) //14

// ES6 - Parcel, Webpack
// 매개변수의 기본값 줄 수 있음.
function hap3(a = 2, b = 3) {
  return a + b
}

//Rest Parameter -> numvers의 값이 아래의 값으로 치환이 됨
function sum(...numbers) {
  console.log(numbers) // [1,3,5,7,9]
}
sum(1, 3, 5, 7, 9)

function sum2(x, y, ...numbers) {
  console.log(x) //1
  console.log(y) //3
  console.log(numbers) // [5,7,9]
}
sum2(1, 3, 5, 7, 9)
