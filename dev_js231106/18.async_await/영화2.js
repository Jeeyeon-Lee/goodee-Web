//OMDB API 활용
const movieList = (movieTitle) => {
  return new Promise((resolve, reject) => {
    fetch(`http://www.omdbapi.com/?apikey=67c29dc9&s=${movieTitle}`)
      .then((response) => response.json())
      .then((response) => {
        console.log(response)
        resolve()
      })
  })
}

const wrapping = async () => {
  await movieList('avatar')
  // await console.log('아바타'); console은 promise 타입이 아니기에 await 쓸 수 없음
  console.log('아바타')
  await movieList('frozen')
  console.log('겨울왕국')
  await movieList('avengers')
  console.log('어벤저스')
}
//fetch 함수는 repl로 확인x -> html 문서 통해 실행 필요

//주의 : 함수 꼭 호출하기!!
wrapping()
