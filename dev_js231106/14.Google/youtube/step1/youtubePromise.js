const mostViedo = async () => {
  fetch(
    'https://www.googleapis.com/youtube/v3/videos?part=snippet&key=AIzaSyAzxSeXI1gsMWlv9rjkOfzasmyOcux9MX0&maxResults=12&chart=mostPopular',
  )
    .then(async (res) => {
      const data = await res.json()
      console.log(data)
    })
    .catch((error) => console.log('error', error))
}
const wrapping = async () => {
  await mostViedo()
}
