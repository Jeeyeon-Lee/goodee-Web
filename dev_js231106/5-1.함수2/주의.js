//주의사항
//불변성 Immutability 파라미터로 참조형 받을 수 있음-원시형 해당x
//원시값(값에 의한 복사)/객체값(참조에 의한 복사-메모리 복제-불변-원본 바뀜-사이드이펙트)
//JS는 함수 선언시 타입결정x, 런타임에서 결정o
function funcA(num) {
  num = 5
  console.log(num)
}
// console.log(num) //defined

//원시형인 경우, 함수내부에서 변경되더라도 외부에 영향 x
const value = 3 //3으로 초기화
console.log(funcA(value))
console.log(value) //바깥에는 영향이 없음

//참조형인경우 원본이 바뀜 -> 가급적 자제 (call by reference)
const fruit = { name: '🍓' }
function funcB(obj) {
  obj.name = '🍉'
  console.log(obj)
}
funcB(fruit)
console.log(fruit) //{ name: '🍉' }
