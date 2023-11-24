//전개연산자 spread operator
const fruits = ['🍓', '🍉', '🍎', '🍌']

//기존 -> 배열로 출력
console.log(fruits) //['🍓', '🍉', '🍎']
// ... 전개연산자 -> 하나씩 전개되어 출력
console.log(...fruits) //'🍓', '🍉', '🍎'

// , 열거형 연산자
// 매개변수에서 '...c'라는 전개연산자를  통해 그 나머지 인자도 c 안에 전개되어 배열로 받아올 수 있음. .
// 속성의 이름과 데이터의 이름이 같으면 축약형으로 가능（이 형식으로 작성함)
toObject = (a, b, ...c) => {
  return {
    a,b,c,
  }
}
toObject2 = (a, b, ...c) => {
  return {
    //리턴 안에는 객체가 옴(키, 값)
    a: a, b: b, c: c,
  }
}
toObject3 = (a, b, ...c) => ({a, b, c})

console.log(toObject(...fruits)) // {a:'🍓', b:'🍉',c:['🍎', '🍌']}
console.log(toObject2(...fruits)) // {a:'🍓', b:'🍉',c:['🍎', '🍌']}
console.log(toObject3(...fruits)) // {a:'🍓', b:'🍉',c:['🍎', '🍌']}
