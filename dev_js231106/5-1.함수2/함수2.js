// flase로 나오는 6가지 : false, 0, null, NaN, "", undefined
add = (a, b) => {
  return a + b
}
console.log(add)
console.log(add(1, 3))
console.log(typeof add)
console.log(typeof add(1, 3))
// JS는 리턴타입 선언 자리 없음, 리턴을 쓰지 않으면 undefined 반환됨.
// JS는 함수의 치환이 가능(함수가 객체급임) -> add와 hap이 같은 주소번지를 갖고 있음.
// JS는 함수의 파라미터(타입, 갯수) 달라도 이름이 같으면 호출이 된다. but, 같은 이름의 함수를 가질 수 없음(오버로딩x)
console.log(add) //function : add
const hap = add //같은 주소번지
console.log(hap == add) //같은 값
console.log(hap === add) //같은 타입
console.log(typeof hap)
console.log(typeof add)

//false로 나오는 것 -> 0으로
console.log(hap()) //NaN
console.log(hap(1, null)) //1
console.log(hap(1, NaN)) //1 NaN
console.log(hap(1, [])) // '1'
console.log(hap(1, {})) // 1[object Object] 값은 1로 나오지만, 타입이 나옴
console.log(typeof {}) // 'object'
