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
//아바타 조회 후 then 어벤저스 조회하기
movieList('harry potter')
  .then(() => {
    console.log('해리포터')
    return movieList('avengers')
  })
  .then(() => {
    console.log('어벤저스')
    return movieList('home alone')
  })
  .then(() => {
    console.log('나홀로집에')
  })
