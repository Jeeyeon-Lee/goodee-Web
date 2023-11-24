const words = ['spray', 'elite', 'exuberant', 'destruction', 'present']

const result2 = words.filter
console.log(result2)
const result = words.filter((word) => word.length > 6)
console.log(result)

//필터값인 result는 array(배열), object이고, 새로운 배열을 생성하는 얕은 복사이다.

//배열->filter->얕은복사 or 깊은복사????
//->filter는 다른 여러 객체에서 재사용할 수 있는 prototype이 생성되는 것이다. 얕은복사
//->filter 함수는 리턴타입이 배열이다. 깊은복사(새로운 배열, 주소번지 다름)
console.log(typeof result) //'object'
console.log(result.length) //3 : array여서 길이 확인 가능
words.push('abcdefg')
console.log(words)

console.log(result)

//배열에 대한 초기화 한줄로 끝냄 -> 구조분해 할당의 장점 
const [r1, r2, r3] = result
console.log(r1)
console.log(r2)
console.log(r3)
