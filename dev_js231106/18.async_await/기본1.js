//Async , Await

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

//await 뒤의 비동기 함수 a
// await a() //'await' is only allowed within async function

const wrapping = async () => {
  await a()
  b()
}

wrapping()
