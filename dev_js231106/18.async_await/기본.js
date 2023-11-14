//Async , Await
//1 다음에 2 출력하려면??? 어떻게????
//then을 promise와 함께 써보자,

// console.log(fetch('http://www.omdbapi.com/?apikey=67c29dc9&s=frozen&page=2'))

//코드 a는 1초 후 실행되는 비동기 코드이며, 리턴타입은 promise임.
//a 실행 후 b의 실행을 보장받기 위해 then() 을 사용함.
const a = () => {
  return new Promise((resolve) => {
    setTimeout(() => {
      console.log(1)
      resolve()
    }, 1000)
  })
}

const b = () => {
  console.log(2)
}

//a는 리턴타입이 promise 인스턴스라서 then 메소드 쓸 수 있지만, b는 안 됨.
a().then(() => b)
// b().then(() => a) //cannot read properties of undefined(reading 'then')
