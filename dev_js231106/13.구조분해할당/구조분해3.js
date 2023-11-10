//데이터셋이 스프링이 비벼지는 부분이라면?
//구조분해는?  myBook의 과정은 ??
/*(입력-처리-출력)
(입력)html(ejs)[Was-views-물리적위치-배포,배치-DevOps] -> 조회버튼 -> (자바)
-> 오라클(select *from 도서) -> List<Map>(리턴타입) ->JSON포맷으로 전환(com.google.gson.Gson - gson.jar)
-> 자바스크립트(인터페이스 : 접점)->자바스크립트 : ajax, XMLHttosRequest, fetch() - 비동기처리
*/

//객체
const user = {
  name: '신입',
  age: 30,
  email: '신입@gamail.com',
}

const user2 = {
  address: '서울시 마포구 공덕동',
  address2 : '서울시 금천구 가산동'
}

const { name, age, email, address } = user

console.log(name)
console.log(user.email)
console.log(user['age'])
console.log(address) ////adress로 인해 undefined 뜸

console.log(`${user2['address']}`) ////adress로 인해 undefined 뜸
console.log(user2.address)

const {address2 ='부산시'} =user2
console.log(user2.address2); //'서울시 금천구 가산동'
console.log(address2); //'서울시 금천구 가산동'