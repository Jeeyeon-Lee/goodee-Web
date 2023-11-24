//OMDB API 활용
const movieList = (movieTitle) => {
  return new Promise((resolve, reject) => {
    fetch(`http://www.omdbapi.com/?apikey=67c29dc9&s=${movieTitle}`)
      .then((res) => res.json())
      .then((json) => {
        console.log(`json 응답여부 : ${json.Response}`)
        console.log(`검색되는 총 갯수 : ${json.totalResults}`)
        if (json.Response === 'False') {
          reject(json.Error)
        }
        resolve(json)
      })
      .catch((error) => {
        reject(error)
      })
      .finally(() => console.log('무조건 호출'))
  })
}

movieList('avatar')
  .then((movies) => console.log(movies))
  .catch((error) => console.log(error))
  .finally(() => console.log('처리완료'))
  .finally(() => (loading = false))

movieList('Frozen')
  .then((movies) => console.log(movies))
  .catch((error) => console.log(error))
  .finally(() => console.log('처리완료'))
  .finally(() => (loading = false))
