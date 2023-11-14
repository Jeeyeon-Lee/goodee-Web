//OMDB API 활용
const movieList = (movieTitle) => {
  return new Promise((resolve, reject) => {
    fetch(`http://www.omdbapi.com/?apikey=67c29dc9&s=${movieTitle}`).then(
      (response) => console.log(response),
    )
  })
}

movieList('frozen')
